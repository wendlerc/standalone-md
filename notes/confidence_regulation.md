# Confidence regulation using null-space of output embeddings
**Chris Wendler,**
**06/31/24**

Suppose the SVD spectrum of the output embedding matrix $$W$$ is not full rank. Let's call the space spanned by the singular vectors $$U$$ and the null-space $$U^{\perp}$$. 

Since, $$\mathbb{R}^{d} = U \oplus U^{\perp}$$ we can write any latent as a sum $$z = z_{U} + z_{U^{\perp}}$$ with $$z_U \in U$$ and $$z_{U^{\perp}} \in U^{\perp}$$. 

Let's consider the output of the last transformer block $$z = z_{U} + z_{U^{\perp}}$$ and let's add $$t = t_{U^{\perp}} \in U^{\perp}$$ to it. In essence, the decoding of $$z + t$$ is performed by applying a normalization layer, roughly of the form, $$L(z + t) = \frac{z + t}{\|z + t\|}$$ and a multiplication with the unembedding matrix $$W$$ followed by the softmax operation. Thus, we have
$$W L(z + t) = \frac{1}{\|z + t\|} W (z + t) = \frac{1}{\|z + t\|} W z_U,$$
in which the last equality holds because $$t$$ and $$z_{U^{\perp}}$$ are both in $$U^{\perp}$$. 

As can be seen, adding energy to the null space of $$W$$ is effectively increasing the temperature of the next token distribution.