# Data augmentation

Given some frames with corresponding actions $$(f_1, a_0), (f_2, a_1), ...$$ we condition using the action of the previous frame when creating the current frame.

Further, let $$v = f_2 - z$$. And $$v(f_{2t}, a_1, t)$$ the model prediction.

Basically, one reasonable thing to encourage should be $$d(v, v(f_{2t}, a_1, t)) < d(v, v(f_{2t}, a_{\neq1}, t))$$.

How to reasonably implement this?

## Implementation: contrastive action-conditioning on the diffusion target

We want the prediction with the correct action to be closer to the target than predictions with mismatched actions:
$$
d!\left(v,; v_\theta(f_{2t}, a_{\text{pos}}, t)\right)
< d!\left(v,; v_\theta(f_{2t}, a_{\text{neg}}, t)\right).
$$
Add a contrastive term to the standard diffusion loss.

### Base diffusion loss (v-pred)

* Sample timestep $$t$$, add noise to the latent/frame to get $$f_{2t}$$.
* Compute the ground-truth velocity/noise target $$v$$.
* Predict with the correct action $$a_{\text{pos}} = a_{1}$$:
  $$ \hat v_{\text{pos}} = v_\theta(f_{2t}, a_{\text{pos}}, t) $$.
* MSE loss: $$ \mathcal{L}*{\text{mse}} = |v - \hat v*{\text{pos}}|_2^2 $$ (optionally SNR-weighted).

### Negatives via batch shuffling

* Construct $$K$$ negatives by shuffling actions within the batch (and/or mixing from a queue):
  $$ a_{\text{neg}}^{(k)} \sim \text{shuffle}(a_{\text{pos}}) $$.
* Predict for each negative:
  $$ \hat v_{\text{neg}}^{(k)} = v_\theta(f_{2t}, a_{\text{neg}}^{(k)}, t) $$.

### Contrastive objective (InfoNCE or Triplet)

* Define per-sample distances:
* $$ d_{\text{pos}} = |v - \hat v_{\text{pos}}|*2^2 $$, and
  $$ d*{\text{neg}}^{(k)} = |v - \hat v_{\text{neg}}^{(k)}|_2^2 $$.
* Scores: $$ s_{\text{pos}} = -d_{\text{pos}}/\tau $$, $$ s_{\text{neg}}^{(k)} = -d_{\text{neg}}^{(k)}/\tau $$ with temperature $$\tau$$.
* InfoNCE:
  $$ \mathcal{L}*{\text{nce}} = -\log\frac{\exp(s*{\text{pos}})}{\exp(s_{\text{pos}}) + \sum_k \exp(s_{\text{neg}}^{(k)})} $$.
* Alternatively, Triplet with margin $$m$$:
  $$ \mathcal{L}*{\text{triplet}} = \max(0,, m + d*{\text{pos}} - \min_k d_{\text{neg}}^{(k)}) $$.

### Max-margin (marginless) variants

Avoid choosing a margin by using margin-free ranking surrogates:

* Zero-margin hinge (hard max-margin):
  $$ \mathcal{L}*{\text{hinge-0}} = \max!\big(0,, d*{\text{pos}} - \min_k d_{\text{neg}}^{(k)}\big). $$
* Softplus (smooth hinge):
  $$ \mathcal{L}*{\text{soft}} = \text{softplus}!\big(d*{\text{pos}} - \min_k d_{\text{neg}}^{(k)}\big). $$
* Pairwise logistic over all negatives:
  $$ \mathcal{L}*{\text{logistic}} = \tfrac{1}{K}\sum_k \log!\big(1 + \exp(d*{\text{pos}} - d_{\text{neg}}^{(k)})\big). $$
  These enforce $$d_{\text{pos}} < d_{\text{neg}}$$ without an explicit margin. If needed, normalize distances per-batch (subtract mean, divide by std) to reduce scale sensitivity.

### Total loss

Combine with a balancing weight $$\lambda$$:
$$ \mathcal{L} = \mathcal{L}*{\text{mse}} + \lambda \cdot \mathcal{L}*{\text{nce}} $$
(or replace nce with triplet).

### Conclusion

When using **exactly one negative action**, InfoNCE simplifies to the logistic/softplus ranking loss. Specifically:

$$
\mathcal{L}*{\text{NCE}} = \log\left(1 + \exp\left(\frac{d*{\text{pos}} - d_{\text{neg}}}{\tau}\right)\right)
= \text{softplus}\left(\frac{d_{\text{pos}} - d_{\text{neg}}}{\tau}\right).
$$

This is mathematically equivalent to a binary logistic loss with logit:

$$
x = \frac{d_{\text{neg}} - d_{\text{pos}}}{\tau},
$$

and target label $$y = 1$$. Implemented using PyTorch:

```python
logits = (d_neg - d_pos) / tau
loss = F.binary_cross_entropy_with_logits(logits, torch.ones_like(d_pos))
```

This enforces exactly the desired inequality

$$ d_{\text{pos}} < d_{\text{neg}} $$

while remaining stable, differentiable, and temperature-controlled.
