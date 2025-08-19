# Steering large language models
**Chris Wendler,**
**03/11/24**

Superposition theory ([toy models](https://transformer-circuits.pub/2022/toy_model/index.html), [monosemanticity](https://transformer-circuits.pub/2023/monosemantic-features/index.html)) suggests that neural networks represent features as vectors (e.g., of neuron activations; or of the stuff that is in the residual stream). 

Let's suppose this holds. A latent at layer $$i$$ takes the form
$$z = \sum_{j} \alpha_j f_j,$$ with $$\alpha_j \in \mathbb{R}$$ and $$f_j \in \mathbb{R}^d$$.

Given this linear representation, a representation leveraging an abstract concept space for dealing with, e.g., multilingual data, could look like this:
$$z = z_{\text{concept}} + z_{\text{decoding language}} + z_{\text{rest}}.$$

Now, if we had a method to compute $$z_{\text{decoding language}}$$ or $$\triangle = z_{\text{target language}} - z_{\text{source language}}$$, we could change the output language by the following 
intervention: 
$$z' = z - z_{\text{source language}} + z_{\text{target language}} = z + \triangle.$$

# (Informal) current steering

Let's consider, e.g., $$\ell_1 = \text{RU}$$ as source language and $$\ell_2 = \text{ZH}$$ as target language and the following simplified model $$z = z_{\text{target language}} + z_{\text{rest}},$$
with $$z_{\text{rest}} \sim N(0, \sigma)$$.

We can estimate $$z_{\ell}$$ using a dataset of latents $$D_{\ell}$$, with $$\mid D_{\ell}\mid = n$$ that all share the feature $$z_{\ell} \in \mathbb{R}^d$$:

$$z_{\ell} \approx \frac{1}{n}\sum_{z \in D_{\ell}} z = z_{\ell} + \underbrace{\frac{1}{n} \sum_{k} z_{r_k}}_{\approx 0}.$$

# Better 

We can drop the assumption $$z_{\text{rest}} \sim N(0, \sigma)$$ by observing 
$$\mu = \frac{1}{n} \sum_{z \in D_{\ell}} z = z_{\ell} + \mu_r,$$
since $z_{\ell}$ is shared among all examples. As a result, we can compute $$\triangle$$ by computing the difference $$\triangle = \mu_2 - \mu_1 = \mu_{r} + z_{\ell_2} - \mu_{r} - z_{\ell_1} = z_{\ell_2} - z_{\ell_1}.$$


# Better ways of computing the steering vector 

More generally, we'd want to solve the following optimization problem

$$\min_{z_{\ell} \neq 0, z_{r_1}, \dots, z_{r_n} \in R^{d}} \sum_{i = 1}^n \|z_i - (z_{r_i} + z_{\ell})\|^2.$$

(?) $$z \mapsto z_{r} = z - z_{\ell}$$ is linear $$\to$$ linear regression?


