# Direct logit attribution
**Chris Wendler,**
**03/19/24**

Let's consider the $$i$$ th attention head at layer $$\ell$$: $$a^{(\ell i)} \in \mathbb{R}^d$$. With layer I mean transformer block (attention followed by MLP).

Since, we typically use a residual architecture, $$a^{(\ell i)}$$ will enter the logits in the following way
$$\text{logits} = W_U(a^{(\ell i) }+ R(a^{(\ell i)})),$$
in which $$R$$ denotes the computation subsequent to the attention layer $$\ell$$, i.e., the MLP of layer $$\ell$$ and all subsequent transformer blocks.

By linearity we have
$$\text{logits} =  \underbrace{W_U a^{(\ell i)}}_{\text{direct eff.}} + \underbrace{W_U R(a^{(\ell i)})}_{\text{indirect eff.}}.$$

N.B.: For the sake of simplicity I omitted the layernorm operation, but as we saw [here](https://dynalist.io/d/n2ZWtnoYHrU1s4vnFSAQ519J#z=disz2gTx-jooAcR0a5r8e7LZ) it can be well approximated by its first order approximation.
