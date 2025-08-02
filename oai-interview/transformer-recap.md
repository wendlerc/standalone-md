# Absolute positional encodings

[Geogebra](https://www.geogebra.org/calculator/hxrhp3vt) is nice to play around.


**Takeaways**
- $$\sin(x), \cos(x)$$ have period equal to $$2\pi$$. Thus, $$\sin(\frac{x}{C})$$ has period $$2 C \pi$$. In positional encodings this constant C is set to $$10000^{\frac{2 k}{d}}$$ in which $$k$$ is the $$k$$th dimension of the positional encoding vector and $$d$$ is the latent dimension of the transformer. Thus, in the different dimensions we simply create sine and cosine waves with different periods, ranging e.g. from $$2\pi$$ ($$k=0$$) to $$5000$$ ($$k=255$$) with $$d = 512$$.
- The resulting positional encoding vectors resemble a soft version of a binary number encoding. If two numbers are far apart, even their low-frequency dimensions will disagree, whereas if they are close together they will agree on the lower frequencies but disagree on the higher ones ($$k$$ closer to 0):
$$
p(x) = \begin{cases}
\sin\left(\frac{x}{10000^{\frac{2k}{d}}}\right) & \text{for } k \geq 0 \text{ and } k < 256 \\
\cos\left(\frac{x}{10000^{\frac{2k}{d}}}\right) & \text{for } k \geq 256 \text{ and } k < d
\end{cases}
$$
- Edit: I just checked and in most implementations they put the sine waves into even ($$k=2j$$) and cosine waves into odd ($$k=2j+1$$)components but that's equivalent to what we are doing here.