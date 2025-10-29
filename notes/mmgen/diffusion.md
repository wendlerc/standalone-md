# Notation

$$x_0$$ ... clean datapoint
$$x_T$$ ... (pure) noise
$$x_t$$ ... noised datapoint


# Toy example

$$x_0$$ is a sample of r.v. $$X_0 \sim p_{\mbox{data}}(x)$$ 
$$x_T$$ is a sample of r.v. $$X_T \sim N(x; 0, 1)$$; $$X_T$$ and $$\epsilon$$ can be used interchangably

Helpful assumption: $$Var(X_0) = Var(X_T) = 1$$.

We can design $$X_t = a_t X_0 + b_t X_T$$ such that $$Var(X_t) = 1$$. 


$$\mathbb{E}[X_t] = a_t E[X_0] + b_t\mathbb{E}[X_T] = a_t E[X_0]$$.

$$Var(X_t) = E[X_t^2] - E[X_t]^2$$ N.R. $$(\mathbb{E}[(x - m)^2] = E[x^2] - 2E[x]E[x] + E[x]^2 = E[x^2] - E[x]^2$$

$$E[X_t^2] - (a_t E[X_0])^2 = a_t^2 E[X_0^2] + b_t^2 - a_t^2 E[X_0]^2 = a_t^2 Var(X_0) + b_t^2 = a_t^2 + b_t^2$$


NR. X_0 indep. X_T, thus, $$E[X_t^2] = E[a_t^2 X_0^2 + 2 a_t X_0 b_t X_T + b_t^2 X_T^2] = a_t^2 E[X_0^2] + 2 a_t b_t E[X_0] E[X_T] + b_t^2 Var(X_T) = a_t^2 E[X_0^2] + b_t^2 Var(X_T)$$

As a result, we get the constraint $$a_t^2 + b_t^2 = 1$$ which we can use to link them together $$a_t = \sqrt{1 - b_t^2}$$.

Since we want that $$X_T = \epsilon$$ and $$X_0 = X_0$$, $$b_0 = 0$$ and $$b_T = 1$$.

How is this different from the linear interpolation that we have in flow-matching?

$$x_t = x_T + (T - t) * (x_0 - x_T)$$, with $$T = 1$$ and $$t \in [0, 1]$$? --> diffusion weights are non-linear in t.

# Forward process

The idea here is to obtain $$x_t$$ from $$x_{t - 1}$$ by adding a little bit of Gaussian noise, i.e., $$X_t = c_t X_{t - 1} + d_t \epsilon$$. Again since we want $$Var(X_t) = 1$$, we have $$d_t = \sqrt{1 - c_t^2}$$. Okay and $$c_t^2$$ here is typically called $$\alpha_t$$. 

Thus, we have $$X_t = \sqrt{\alpha_t} X_{t-1} + \sqrt{1 - \alpha_t} \epsilon$$ which is distributed according to $$q(x_t \mid x_{t-1}) = N(x_t; \sqrt{\alpha_t} X_{t-1}, 1 - \alpha_t)$$.


Successively applying gives: $$q(x_t \mid x_0)$$


E.g., consider $$X_2 = \sqrt{\alpha_1} X_1 + \sqrt{1 - \alpha_1} \epsilon = \sqrt{\alpha_1} (\sqrt{\alpha_0} X_0 + \sqrt{1  - \alpha_0} \epsilon) + \sqrt{1 - \alpha_1} \epsilon$$

$$ = \sqrt{\alpha_1} \sqrt{\alpha_0} X_0 + \sqrt{\alpha_1} \sqrt{1  - \alpha_0} \epsilon + \sqrt{1 - \alpha_1} \epsilon$$

Okay so we have something that is distributed according to the sum of two Gaussians: 
NR.: $$(*) = \sqrt{\alpha_1} \sqrt{1  - \alpha_0} \epsilon + \sqrt{1 - \alpha_1} \epsilon$$

$$N(x; 0, a) + N(x; 0, b) = N(x; 0, ?)$$ if the two Gaussians are indpendent: we have N(x; 0, a + b)$$

Thus, in our case we have $$Var(*) = \alpha_1 (1 - \alpha_0) + (1 - \alpha_1) = \alpha_1 - \alpha_0 \alpha_1 + 1 - \alpha_1 = 1 - \alpha_0 \alpha_1 = 1 - \bar{\alpha}_2$$, where $$\bar{\alpha}_t = \prod_{i = 0}^{t-1} \alpha_i$$. 

## Setting a noise schedule

When setting different $$\bar{\alpha}_t$$, we can compute $$\alpha_t$$ using $$\alpha_t = \frac{\bar{\alpha}_{t+1}}{\bar{\alpha}_t}$$

So defining $$\bar{\alpha}_t$$ for $$t=0, \dots, T$$ we can train a model and subsequently sample it optimally using the corresponding $$\alpha_t$$.

# Backward process

Let $$\epsilon_{\theta}(x_t, t)$$ be our noise prediction.

Then based on rewriting $$x_t = \sqrt{\alpha_t} x_{t-1} +  \sqrt{1 - \alpha_t} \epsilon$$ to 
$$\frac{x_t -  \sqrt{1 - \alpha_t} \epsilon}{\sqrt{\alpha_t}} = x_{t-1}$$ we get our prediction rule:
$$x_{t-1} \approx \frac{x_t -  \sqrt{1 - \alpha_t} \epsilon_{\theta}(x_t, t)}{\sqrt{\alpha_t}}$$


# Backward process (GPT)

Let $$\varepsilon_{\theta}(x_t, t)$$ be our model’s **noise prediction** at step $$t$$.

---

## True posterior

The forward process  
$$
q(x_t \mid x_{t-1}) = \mathcal{N}\big(x_t; \sqrt{\alpha_t} x_{t-1}, (1 - \alpha_t)I \big)
$$
induces a true posterior
$$
q(x_{t-1} \mid x_t, x_0) = \mathcal{N}\!\big(\mu_t(x_t, x_0), \tilde{\beta}_t I\big),
$$
where
$$
\begin{aligned}
\mu_t(x_t, x_0)
&= \frac{\sqrt{\bar{\alpha}_{t-1}}\beta_t}{1 - \bar{\alpha}_t}\, x_0
  + \frac{\sqrt{\alpha_t}(1 - \bar{\alpha}_{t-1})}{1 - \bar{\alpha}_t}\, x_t, \\
\tilde{\beta}_t
&= \beta_t \frac{1 - \bar{\alpha}_{t-1}}{1 - \bar{\alpha}_t}, \quad
\text{and } \beta_t = 1 - \alpha_t.
\end{aligned}
$$

---

## Replacing $$x_0$$ with the model prediction

Instead of conditioning on the true $$x_0$$, we use the model’s noise prediction to estimate it:
$$
\hat{x}_0(x_t, t)
= \frac{x_t - \sqrt{1 - \bar{\alpha}_t}\, \varepsilon_\theta(x_t, t)}{\sqrt{\bar{\alpha}_t}}.
$$

Substituting $$\hat{x}_0$$ into $$\mu_t(x_t, x_0)$$ gives the **sampling mean**:
$$
\boxed{
\mu_\theta(x_t, t)
= \frac{1}{\sqrt{\alpha_t}}
\left(
x_t - \frac{\beta_t}{\sqrt{1 - \bar{\alpha}_t}}\, \varepsilon_\theta(x_t, t)
\right).
}
$$

---

## Sampling rule

The backward sampling step is:
$$
x_{t-1}
= \mu_\theta(x_t, t)
+ \sqrt{\tilde{\beta}_t}\, z,
\quad z \sim \mathcal{N}(0, I).
$$

---

## Deterministic variant (DDIM)

For deterministic sampling (DDIM), set $$\eta = 0$$:
$$
x_{t-1}
= \mu_\theta(x_t, t)
+ \eta\, \sqrt{\tilde{\beta}_t}\, z,
\quad \eta = 0 \text{ (deterministic case)}.
$$

---

**Summary:**  
- The model predicts $$\varepsilon_\theta(x_t, t)$$, an estimate of the marginal noise at time $$t$$.  
- The correct scaling in the backward mean uses $$\displaystyle \frac{\beta_t}{\sqrt{1 - \bar{\alpha}_t}}$$, not $$\sqrt{1 - \alpha_t}$$.  
- $$\bar{\alpha}_t = \prod_{s=1}^t \alpha_s$$ defines the cumulative signal level.

# Backward Variance

There are several related notions of variance in the backward (reverse) diffusion process. Let’s distinguish them clearly.

---

## 1. True posterior variance

Given the forward kernel
\[
q(x_t \mid x_{t-1}) = \mathcal{N}\!\big(\sqrt{\alpha_t}\,x_{t-1},\ \beta_t I\big),
\qquad \beta_t := 1 - \alpha_t,
\]
and the cumulative product
\[
\bar{\alpha}_t = \prod_{s=1}^t \alpha_s,
\]
the exact one-step posterior is
\[
q(x_{t-1} \mid x_t, x_0)
= \mathcal{N}\!\big(\mu_t(x_t, x_0),\ \tilde{\beta}_t I\big),
\]
where
\[
\boxed{\tilde{\beta}_t = \beta_t\,\frac{1 - \bar{\alpha}_{t-1}}{1 - \bar{\alpha}_t}}.
\]

> ✅ This is the **true posterior variance** — smaller than \(\beta_t\) because conditioning on \(x_t\) reduces uncertainty.

---

## 2. Sampling variance (using the model)

At sampling time, we replace the true \(x_0\) with the model estimate:
\[
\hat{x}_0(x_t, t) = \frac{x_t - \sqrt{1 - \bar{\alpha}_t}\,\varepsilon_\theta(x_t, t)}{\sqrt{\bar{\alpha}_t}}.
\]

Then the **mean** becomes
\[
\mu_\theta(x_t, t)
= \frac{1}{\sqrt{\alpha_t}}
\left(
x_t - \frac{\beta_t}{\sqrt{1 - \bar{\alpha}_t}}\,\varepsilon_\theta(x_t, t)
\right),
\]
and the **variance** for the backward transition is
\[
\boxed{
x_{t-1} = \mu_\theta(x_t, t) + \sqrt{\tilde{\beta}_t}\,z,
\quad z \sim \mathcal{N}(0, I).
}
\]

---

## 3. Practical choices

Different variants use different variance schedules:

- **Fixed (DDPM / Ho et al.)**
  \[
  \sigma_t^2 = \tilde{\beta}_t.
  \]

- **Learned (Nichol–Dhariwal)**
  \[
  \sigma_t^2 = \text{clamp}\big(\text{predicted }\sigma_t^2,\, \tilde{\beta}_t,\, \beta_t\big).
  \]

- **Deterministic (DDIM)**
  \[
  \sigma_t^2 = 0 \quad \Rightarrow \quad x_{t-1} = \mu_\theta(x_t, t).
  \]

- **η-interpolation**
  \[
  \boxed{\sigma_t^2 = \eta^2\,\tilde{\beta}_t},
  \quad \eta \in [0, 1],
  \]
  where:
  - \(\eta = 1\): stochastic DDPM,
  - \(\eta = 0\): deterministic DDIM.

---

## 4. Continuous-time intuition

For the VP-SDE formulation:
\[
dx = f(x, t)\,dt + g(t)\,dW_t, \qquad g(t)^2 = \beta(t),
\]
the reverse-time SDE has instantaneous variance \(g(t)^2\,dt\).
Discretizing and conditioning yields the same variance expression:
\[
\tilde{\beta}_t = \beta_t\,\frac{1 - \bar{\alpha}_{t-1}}{1 - \bar{\alpha}_t}.
\]

---

**✅ Summary**

- The **theoretically correct** backward variance per step is  
  \(\displaystyle \tilde{\beta}_t = \beta_t\,\frac{1 - \bar{\alpha}_{t-1}}{1 - \bar{\alpha}_t}\).
- In practice, you can:
  - Use it as-is (standard DDPM),
  - Learn or clamp it (improved DDPM),
  - Set it to \(0\) for deterministic sampling (DDIM).


