# Notes on rotary positional embeddings (RoPE)
**Chris Wendler,**
**08/19/25**


Let 
$$
R^{d}_{\Theta, m} = 
\begin{pmatrix}
\cos{m\theta_1} & -\sin{m\theta_1} & 0 & 0 & \cdots & 0 & 0 \\
\sin{m\theta_1} & \cos{m\theta_1} & 0 & 0 & \cdots & 0 & 0 \\
0 & 0 & \cos{m\theta_2} & -\sin{m\theta_2} & \cdots & 0 & 0 \\
0 & 0 & \sin{m\theta_2} & \cos{m\theta_2} & \cdots & 0 & 0 \\
0 & 0 & 0 & 0 & \cdots & \cos{m\theta_{d/2}} & -\sin{m\theta_{d/2}} \\
0 & 0 & 0 & 0 & \cdots & \sin{m\theta_{d/2}} & \cos{m\theta_{d/2}} \\
\end{pmatrix}.
$$

Then, we update keys using $$k_n = R^{d}_{\Theta, n} W_k x_n$$ 
and queries using $$q_m = R^{d}_{\Theta, m} W_q x_m$$.

Their dot product simplifies to 
$$
q_m^T k_n = x_m^T W_q^T R^{d}_{\Theta, n - m} W_k x_n.
$$


# Positional-only attention heads

Given positional information only enters via RoPE, how can an attention head be achieved that solely relies on positional information?

## Previous token heads

Let's try to implement a simple previous token head using RoPE. This head should attend mostly to the previous token. E.g., $$q_{n+1}$$ should mostly match with $$k_n$$ and so on.


Their dot product simplifies to 
$$
q_{n+1}^T k_n = x_{n+1}^T W_q^T R^{d}_{\Theta, -1} W_k x_n.
$$

Without assumptions I don't see a straightforward way to achieve this previous token head. However, after discussing with my friend Jakob Heiss, we had the idea that we could assume that the model either has a bias term (one of the components of $$x_i \in \mathbb{R}^d$$ is a constant value) either because that bias term is hardcoded or because the previous layers have learned to create one. 

Thus, w.l.o.g. let's assume that for each $$i$$ we have $$x_{i1} = 1$$. Now, this can be used to create keys and queries that solely depend on the positional information.

Then, we could set $$W_k$$ such that, for all $$i$$, $$W_k x_{i} = (1, 0, 1, 0, \cdots, 1, 0)^T$$. That is, 
$$
W_{kij} := \begin{cases}
1 && \text{if } j = 1 \text{ and } i \text{ is even,}\\
0 && \text{else.}
\end{cases}
$$


$$W_q$$ such that $$W_q x_{n+1}$$ matches $$R^{d}_{\Theta, -1} (1, 0, 1, 0, \cdots, 1, 0)^T = (\cos{\theta_1}, -\sin{\theta_1}, \cdots, \cos{\theta_{d/2}}, -\sin{\theta_{d/2}})$$ to maximize the dot product with $$k_{n}$$. Additionally, we can add a temperature parameter to control how sharp we want the attention head to be. Both can be achieved by setting $$W_q := \alpha R^{d}_{\Theta, -1} W_k,$$ in which $$\alpha > 0$$ is a temperature parameter. 

As a result, for $$q_{n+1}$$ we have that $$q_{n+1}^T k_n = (d/2)\alpha$$ and $$ q_{n+1}^T k_m = \alpha \sum_{\ell = 1}^{d/2} \cos{((m - n)\theta_{\ell})} < (d/2)\alpha $$, for $$m < n$$. Thus, for large $$\alpha$$ the softmax operation in the attention layer should mostly select the key at position $$n$$.
