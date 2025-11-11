Dear Google DeepMind Hiring Team, 
I am writing to apply for the Research Scientist, Generative Worlds role. I am a postdoctoral researcher in David Bau’s interpretable deep learning lab at Northeastern University and previously a postdoc in Robert West’s data science lab at EPFL Lausanne. Across these roles, my work has focused on understanding and controlling large generative models, and I am eager to bring that experience to the frontier of generative world modeling at Google DeepMind. Generative world models like Genie 3 and video models like Veo, to me, represent the second great frontier of AI alongside agentic systems. Innovating in this space, which lives at the boundary of what is possible, by definition means creating something that has never existed before and expanding our human experience to another level. This deeply resonates with my core motivation of scientific curiosity.
Background. This direction naturally connects to my work on text-to-image models, recently culminating in my NeurIPS 2025 accepted paper [1] with my brilliant students Viacheslav Surkov, who initiated the direction, and Antonio Mari, who advanced it significantly. In this work, we extended sparse autoencoders (SAEs) to the visual stream of state-of-the-art text-to-image models such as SDXL and FLUX. These interpretable features, learned entirely without supervision, act almost like brush tools that controllably affect image generation within spatial regions. Critically, features learned in distilled models (SDXL Turbo, FLUX Schnell) transfer to the base models without retraining, demonstrating a feasible path toward scalable, interpretable control. Conceptually, this non-linguistic control mechanism parallels the learned latent actions in Genie 1 and represents a research direction I find deeply compelling. The visual domain is inherently interpretable to us and since most of it cannot be appropriately captured in words we need to go beyond the current paradigm powered by large language models to reach this technology’s full potential. 
My interest in diffusion models deepened during the period between my PhD at ETH Zurich and my EPFL postdoc, when I volunteered as an open-source contributor at LAION and contracted at Stability AI. There, I built large-scale image-text datasets with OCR annotations to teach SDXL to render text. One of the datasets we created, RenderedText [2] (12 million pieces of paper containing text with character-level annotations rendered into 3D environments using Blender), has since been used to train popular vision-language models such as DeepSeek-VL2 [3] and Idefics [4]. After my contractor role, I kept collaborating with Peter Baylies, who mentored me at Stability AI, and I trained latent CLIP: a CLIP model capable of processing SDXL's latent images without the need of decoding them to images [5]. Peter and I were building many different datasets for Stability, a company famous for their latent diffusion models and championing the only open-source variational autoencoder with strong reconstruction quality for high resolution images for a long time. For us latent CLIP was a natural idea at the time. Training a ViT-B sized latent CLIP, represents my biggest pretraining run so far, leveraging open-clip’s DDP trainer on 128 NVIDIA A100 GPUs for 4 days and 9.5 hours. I only briefly had access to this number of graphics cards while the Stability AI open-source contributors cluster still existed and leveraged it to precompute latent images for more than 2 billion images in the LAION 2B dataset under 4 different data augmentations, resulting in a dataset of about 10 billion latent images, which I used to train latent CLIP. Since my time at Stability and thanks to my mentor Peter Baylies, who I have been meeting almost weekly since, I knew I had an edge in this space and made sure to  always keep independently pushing this direction further (even when sometimes not perfectly aligned with my postdoc roles in research groups mostly focused on large language models). Thus, I am extremely proud of my effort and dedication that I put into this direction and what I have accomplished by doing so.
Vision. Another particularly exciting aspect of world model research is the potential to create interactive experiences that benefit humanity in ways that are hard to imagine today. Breakthroughs in this area will transform a broad range of fields simultaneously, similar to how chat models today. 
One example I often return to is psychotherapy. Interestingly, VR-based therapy has already begun to show promise in the treatment of schizophrenia. I first learned about this through my brother, Hannes Wendler, a doctoral student working at the intersection of philosophy and psychology, during a visit to his conference in Copenhagen (ICNAP 2023). There, Julie Nordgaard presented remarkable work from her lab on developing therapies that use 3D avatars to represent the voices perceived by patients with schizophrenia. By combining these avatars with voice modulation techniques, therapists can temporarily take on the roles of the voices the patients hear. This approach helps shift the power dynamics between patients and their perceived voices, gradually transforming negative experiences into empowering ones. Beyond direct therapy, these avatars also help families better understand and empathize with the patients’ experiences. However, creating such therapeutic environments is currently a manual, labor-intensive process that requires close collaboration between technical experts and clinicians over extended periods. Advances in video and world modeling and in our ability to create, customize, and control interactive experiences, could directly alleviate this bottleneck. 
From a technical perspective, applications like this are especially fascinating because they clearly illustrate what is required to enable such experiences: support for multi-participant, role-based interactions. In these settings, there are creators (the therapists) and receivers (the patients), each with distinct objectives, modes of engagement, and perspectives within the shared simulated world. This structure opens the door for creativity and innovation. At the same time, fundamental challenges such as maintaining consistency, long-term coherence, spatial memory, realism, controllability, and scalability remain central.  
Why deepmind?


Dear Google DeepMind Hiring Team,

I am writing to apply for the Research Scientist, Generative Worlds role. I am a postdoctoral researcher in David Bau’s Interpretable Deep Learning Lab at Northeastern University, where we ask how deep neural networks achieve their remarkable capabilities mechanistically and whether their internal computations can be made legible to humans. 

Over the last years I have focused on large generative models. With Robert West at EPFL, I co authored “Do Llamas Work in English?”, which used simple intermediate decoding analysis to study how LLMs process non English text and helped pull me fully into mechanistic interpretability. Since then I have built and led a line of work on text to image models: together with Viacheslav Surkov and Antonio Mari I developed a sparse autoencoder framework for SDXL, FLUX, and SD3. We uncovered block specialization in SDXL and achieved causal control over image generation with thousands of feature “brushes”. This work has been accepted at NeurIPS 2025 and led to a new ICLR 2026 submission. Earlier, during a contractor role at Stability AI, I trained a latent CLIP model in SDXL’s VAE latent space to enable efficient filtering and reward based adaptation of generated images. Across these projects I have learned how to interrogate and steer large generative systems, build tools others can use, and coordinate student led projects from rough idea to polished paper.

Generative world models like Genie 3 and video models like VEO feel like the natural next step. They combine the representational richness of diffusion and video transformers with structured, interactive environments. To me they are one of the most remarkable developments in AI so far, on par with the original AlexNet and AlphaGo moments. They will not only change what agents and robots can do, but also how humans learn, practice, and relate to complex environments.

One concrete example I often think about is surgical training. Today, junior surgeons slowly progress from textbooks and mannequins to assisting in real operations, with access to cadaver based training limited in many regions. In the near future, it seems entirely realistic that they will rehearse rare procedures inside a virtual operating room powered by a world model, possibly together with senior surgeons who can guide, pause, and adjust the simulation. A similar pattern already appears in psychotherapy, where VR is used to externalize and interact with distressing voices or situations. These are not far future science fiction scenarios, they are clear, economically viable applications that demand highly realistic, controllable, multi agent simulations.

For this vision to be safe and robust, we need to understand how world models represent physics, agents, goals, and rewards. My research so far has been about opening up black box generative models and gaining causal handles on their behavior. I see a direct line from sparse autoencoders on SDXL and FLUX, and latent CLIP based reward shaping, to future work that reverse engineers world models. Questions I am excited to pursue include whether these models build genuine abstractions of objects and agents, how they encode persistent state over long horizons, and how objectives like engagement or task success are reflected in their internal computations and can be manipulated predictably.

I also enjoy the engineering and collaboration this agenda requires. In my current role I mentor students, manage shared codebases, and help maintain the infrastructure we use to run multi billion parameter models in the cloud. I like turning messy experimental scripts into tools that others in the lab can apply, and I am comfortable iterating directly with product minded teams, as I did at Stability AI when we translated interpretability ideas into practical filtering and guidance mechanisms.

DeepMind is the place where I most want to do this work. Your world model efforts, including Genie 3, have been a constant source of inspiration, just like earlier milestones such as DQN, AlphaGo, AlphaZero, AlphaFold, and AlphaTensor. The Generative Worlds team sits exactly at the intersection I care about most: building new world models, understanding them deeply, and exploring their real world impact. I would be excited to bring my experience in mechanistic interpretability of generative models, my background in mathematics and machine learning, and my enthusiasm for world models to this group. I am currently based in New York, so the role’s location is an added bonus.
Thank you for considering my application. I would be very happy to discuss how I could contribute to the Generative Worlds team and to DeepMind’s broader mission.

Sincerely,
Chris Wendler

# virtual experience designer;

Dear Google Deepmind Hiring Team,

I am writing to apply for the "Research Scientist, Generative Worlds" role. I am a postdoctoral researcher in David Bau's interpretable deep learning lab. In our lab we ask how deep neural networks achieve their remarkable capabilities, mechanistically, and whether their internal computations can be made legible to humans. 


That said, to me generative world models like Genie 3 and video models like VEO are by far the most remarkable and most interesting development of our time. With their Genie 3, Jack Parker-Holder, Shlomi Fruchter and the rest of the Genie 3 team truely gifted us with a glimpse into the future and added another entry to Deepmind's ever growing list of paradigm shifting contributions (DQN, AlphaGo, AlphaZero, AlphaFold2, AlphaTensor) and a milestone to Deepmind's journey towards AI. 

It is completely obvious to me that this research direction of generative world modelling using deep neural networks (today transformers, tomorrow maybe something else) offers insights and treasures beyond our current imagination. This entire research space currently lives at the boundary of what's possible and in addition to large language model / agent research presents the second frontier of AI. This technology is almost like an entirely new medium and has the potential to revolutionize many different verticals all at once. For example, consider the training of surgeons, who today have to go through an expensive training process with many steps building up their skills before they can perform their first real surgery. I imagine the two steps most similar to their real target surgery are the human-cadaver based simulation of the target surgery and watching more experienced colleagues perform this surgery. In many parts of the world (parts of Asia, Africa, Eastern Europe) cadaver donations don't meet the requirements of medical doctor training programs. Five years from now, in a world in which generative world models excell, surgeons could train for their upcoming surgery they have to perform inside of a VR experience powered by our world model. Five years from now is not a long time and the simulation must be very accurate for the simulated experience to be helpful for the young surgeon, thus, to make sure the experience is accurate and instructive we can add another real-human participant to the experience, the senior surgeon with lots of experience. Almost like in a video game, the to-be-trained surgeon is immersed in their simulated surgery as a "player 1", while the senior surgeon participates, maybe as an additional "player 2" with the privilege to modify the simulated content towards medical accuracy or as a "game master" ensuring medical accuracy but also that key lessons are learned while staying invisible to "player 1". Or maybe models improve so dramatically that the senior surgeon can effortlessly create such experiences for all sorts of surgeries and novices train in them asynchronously without the need of real-time interventions by the senior. I picked the surgeon training example, because it is easy to imagine that a program like this can make sense not only as a vision, but also from an economical point of view. However, this setup is much more general and will be useful across many different verticals. E.g., it will revolutionize how psychotherapists can treat their patients. In Denmark there is already today a company called HEKA VR [1], which investigate whether VR headsets can improve treatment of schizophrenia. They do this by manually (using a team of technical experts) creating avatars and voice modulations to mimick the voices perceived by the shizophrenic patient. This allows the therapists to take the role of these avatars. The goal of the therapy is to shift power dynamics between the patient and their percieved voices and along the way the therapist also replaces negative things the voices say with more positive ones. Also it is easy to come up with other amazing things that will be enabled by such a technology, some of which are listed in the job post (e.g., enabling top-tier education to children independent from their geographical location and living conditions; training robots more cost-effectively in distilled-, fast world models; creative applications with this new medium by empowering artists; just to name a few).

The blocker for the envisioned scenario is neither the lack of computational resources, nor, the level of quality of VR experiences, nor, the lack of people creating and participating in such experiences. The only thing seperating us from this arguably better world are (pun intended) better world models. World models capable of realistic, consistent, long time horizion simulations that can support multiple participants (humans and agents with potentially vastly different roles as described above) and that makes it seamless to design and customize simulated worlds. The consistency and long time horizon aspects maybe can already be tackled to some extend with today's long-context architectures that leverage learned linear memory blocks such as XLSTM, RWKV, or Deltanet. If these long-context architectures are too hard to train from scratch maybe they can be instantiated from a transformer-based big world model and small adaptations of today's diffusion transformer distiallation techniques such as DMD/CausVid/Self-Force. Multi-agent world models probaby require innovations in the way we pre- and post-train world models. Maybe a post-training step comparable to instruction-tuning with a diverse enough dataset curated using human data from humans in shared experiences or multiple simulated agents can make progress towards something like that, or maybe this requires rethinking the architecture a bit. Lastly, while from what we can observe on text2image models there are already many promising customization techniques, the simpler ones with low enough barriers to be accessible to non-technical users don't seem to be accurate enough and the more involved ones that are capable of better results are not accessible to non-technical users. Maybe scaling the models will get us there or maybe some interpretability inspired customization techniques.  

Talk about my fit:...


with appropriate data containing actions and multiple simulated agents



that allow for indefinitely long simulations with world-consistency, world models that allow a simulation consistent for multiple human and/or argent participants, world models that 

innovations in long-context and learned memory systems (e.g., XLSTM, delta-net, and friends)


[1] HEKA VR, https://hekavr.com/research/



 and therapists can take the role of these avatars

Using their setup, they can already today allow patients 

T to replace the usual mallicious messages from these voices with beneficial ones. Additionally, they also can leverage this setting to shift the power dynamics and empower the patients to  



 a simulation of their upcoming 



 step most similar to the real surgery


It is obvious to me that ... applications: training doctors in simulations, training biologists without animal experiments, democratizing access to education imagine a child independent of where they are born being able to learn whatever humanity has to offer by entering Genie5.




This already brings me to you, since the Genie 3 post, I am captivated by this technology and the future it might hold for us. 



To me, generative world models are by far the most remarkable and most interesting development of our time. Jack Parker-Holder, Shlomi Fruchter and the rest of the Genie 3 team 


with their remarkable execution of Genie 3 have truely shown us a glimpse into the future that I cannot ignore.




To contribute deep learning in this role is t




Much of our research falls within the emerging field of mechanistic interpretability. While most of the field is mostly focused on large language models and their derivates (chat & reasoning models), I am the most excited about extending the field towards text to image models, video and world models. That said I am a deep learning researcher by heart and to me Genie 3 is the by far most interesting development in our field. With their remarkable execution on Genie 3, Jack Parker-Holder, Shlomi Fruchter and their team with their remarkable execution of Genie 3 have truely shown us a glimpse into the future that I cannot ignore.





In my role as a postdoc I am fortunate to advise many brilliant students


 My projects span many different architectures (large language models, reasoning models, text-to-image models, protein folding models) and different research questions (how do capabilities form during pretraining)


My projects (executed by myself and many that I am advising) 
he projects I executing and advising sp

my projects in which I advis

and the advising function that it enables me to perform my projects

As a deep learning researcher, to me Genie 3 is the by far most interesting development in our field. With their remarkable execution on Genie 3, Jack Parker-Holder, Shlomi Fruchter and their team with their remarkable execution of Genie 3 have shown us a glimpse into the future that I cannot ignore.



have shown us a glimpse into the future.

Since the blogpost in August, I have not been able to stop thinking about it. I was familiar with Genie already before and have been talking to world-model start ups. However, 



Genie 3 with its remarkable execution 

 



I am currently a postdoctoral researcher in David Bau's interpretable deep learning lab. In our lab, we ask how deep neural networks trained with gradient descent work mechanistically. 

As a deep learning researcher 
Genie 3 



I am very excited about this job opening, because Genie 3 is in my opinion by far the most interesting 

Vision & how to get there

Background

Why GDM
