# Policy gradient ascent for policies parametrized by LLMs
**Chris Wendler,**
**12/05/23**


Let $$\Sigma$$ be the vocabulary of a LLM, i.e., the set of tokens. 
Let's consider the following summarization task: given a text $$x$$ provide a summary $$y \in \Sigma^{\leq 200}$$, in which $$\Sigma^{\leq 200}$$ denotes the set of sequences that are shorter than $$200$$ tokens.
For the sake of simplicity let's assume that we have a reward function $$r_{seq}(x, y)$$ that rates complete summaries. 

When using RLHF to align LLMs to me it was sometimes not clear what's the state space and what's the action space. In particular, whether to use $$A = \Sigma$ or $A = \Sigma^{\leq 200}$$ as the set of actions. The state space in both cases can be $$S = \Sigma^*$$. 

To answer this question, it suffices to consider [the vanilla policy gradient method](https://spinningup.openai.com/en/latest/spinningup/rl_intro3.html#deriving-the-simplest-policy-gradient) that updates the policy using the following policy gradient $$\nabla_{\theta} J(\pi_{\theta}) = \nabla_{\theta} E_{\tau \sim \pi_{\theta}}[R(\tau)] \approx \frac{1}{\mid D\mid} \sum_{\tau \in D} \sum_{t=0}^T \nabla_{\theta} \log \pi_{\theta}(a_t \mid s_t) R(\tau) = \hat g,$$
in which $$J$$ denotes the performance of the policy $$\pi_{\theta}$$, $$\tau$$ is used for trajectories, $$R(\tau)$$ is the reward of a trajectory, $$D$$ is the set of sampled trajectories.

# Choosing the next-token as an action

We have $$S = \Sigma^*, A = \Sigma$$, importantly, state-transitions are deterministic. Let $$s \in S$$ be a text that we want to summarize, then performing an action $$a \in A$$ moves us to the state $$sa$$ (where we concatenated the sequence $$s$$ and token $$a$$). Formally we have $$\Delta(s, a) := sa$$. As distribution over the initial state $$s_0$$ we use the uniform distribution over a corpus of texts that we want to summarize. In this setting we parametrize the policy using a copy of our pretrained (and instruction tuned) LLM $$\pi_{\theta}(a \mid s) = p_{\theta}(a \mid s)$$. We are in a finite-horizon setting and set $T$ such that text $$s_0$$ together with a $$200$$ token response fits into the context length of our LLM.

In order to define $$R(\tau)$$ that is required for the policy gradient, we need to define a reward $$r: S \times A \to [0, \infty): (s, a) \mapsto \begin{cases} r_{seq}(x, y) & \text{if }a \text{ is end-of-sequence token,} \\
0 & \text{else,} \end{cases}$$ 
where we have to split $$sa = xy$$ into prompt $x$ and response $$y$$ to evaluate $$r_{seq}$$.

Now, for a trajectory $$\tau = (s_0, a_0, \dots, s_{T-1}, a_{T-1})$$ the reward $$R(\tau)$$ is defined, namely, $$R(\tau) = \sum_{t = 0}^{T-1} r(s_t, a_t).$$ Note that, in RLHF papers $$s_0$$ is usually denoted as $$x$$ and the resulting summary as $$y = a_0a_1\dots a_{T-1}$$.

Finally, $$\nabla_{\theta} \log \pi_{\theta}(a_t \mid s_t)$$ is nicely defined via the backward pass through the log-probability of the token $$a_t$$. Putting everything back together gives us a policy gradient that we can use to train $$\pi_{\theta}$$.

# Writing the whole summary as an action

We have $$S = \Sigma^*, A = \Sigma^{\leq 200}$$, importantly, state-transitions are deterministic. Let $$s \in S$$ be a text that we want to summarize, then performing an action $$a \in A$$ moves us to the state $$sa$$ (where we concatenated the sequences $$s$$ and $$a$$). Formally we have $$\Delta(s, a) := sa$$. As distribution over the initial state $$s_0$$ we use the uniform distribution over a corpus of texts that we want to summarize. In this setting we parametrize the policy using a copy of our pretrained (and instruction tuned) LLM $$\pi_{\theta}(a \mid s) =  \prod_{i=1}^m p_{\theta}(a_i \mid s a_{<i}),$$ in which $$a = a_1 a_2 \dots a_m$$ and $$a_{<i}$$ denotes $$a_1\dots a_{i-1}$$ ($$a_{<1}$$ is the empty sequence). We are again in a finite-horizon setting, with $$T=1$$. This time we can use $$r_{seq}$$ directly $$r(s,a) = r_{seq}(s, a)$$. Plugging everything into $$\hat g$$, we get 
$$\begin{aligned}
\hat g &= \frac{1}{\mid D\mid} \sum_{\tau \in D} \nabla_{\theta} \log \pi_{\theta}(a \mid s_0) R(\tau) \\
&= \frac{1}{\mid D\mid} \sum_{\tau \in D} \sum_{i=1}^m \nabla_{\theta} \log p_{\theta}(a_i \mid s_0 a_{<i}) R(\tau) 
\end{aligned},$$
which is an update identical to the one in the previous setting where sampling the next token was the action.