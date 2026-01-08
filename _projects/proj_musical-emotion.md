---
layout: page
title: Musical emotion
description: "How do sounds evoke emotion?<br>Updated: 2024-09-23"
importance: 1
category: music
giscus_comments: true
related_publications: true
---

## Does music evoke emotions?

While the need for verification never personally occurred to me (like.. of course?!), all comes from the fundamental problem of psychology:
_We cannot directly observe others' subjective experiences._

It would be unsurprising that some music does not "tell you anything" (i.e., it does not evoke any "meaningful" emotions other than boredom or disgust).
But, more surprisingly, a systematic survey found that some people just don't like music at all while these people were otherwise not different from those who enjoyed music [(Mas-Herrero et al., 2013)](https://doi.org/10.1525/mp.2013.31.2.118), which was followed by a large-scale survey and neural and physiological correlates.
This particular disinterest in music was termed as "musical anhedonia" although whether this constitutes a clinical deficit to be listed in psychiatric manuals such as DSM-5 is unclear.
Nonetheless, this evoked many studies on individual variability in musical reward sensitivity.

## Does music evoke specific emotions?

While acknowledging the great diversity of emotions evoked across individuals (and cultures) by an identical piece of music, it is still fascinating that such abstract sounds of music can evoke vivid and intense emotions.
But do we experience similar emotions from an identical piece of music?
If not, can we say it is music that evokes a certain emotion?

Or, is this not how affective causality works?
For example, an audio-visual stimulus of a smiling baby👶 (or a baby animal🐶🐱) "generally" evokes a joyful emotion in many people.
But how reliable is this causation?
There are other factors that modulate the evocation of joyful emotion.
But this does not mean the causation (or association?) is completely random[^1].

[^1]: Perhaps this may be even an absolutist confusion about empirical causation. An identical temperature may or may not boil the water depending on the pressure. Does it abolish the causal link between the temperature and the phase transition of the water?🙄

Now, here's our hope: if there exists any kind of stable association between music and evoked emotions, we may model this as a (locally-)time-invariant linear system {% cite kim2022fn %}.
A preliminary result suggests abstract features extracted using a CNN could predict fMRI response time series in the medial prefrontal cortex, which could be more relevant to emotions than acoustic features {% cite kim2023icmpc %}.
Then, we can further investigate how stable this system is within an individual and how variable across individuals, cultures, and even clinical conditions.

## Haven't people tried and failed already?

Even in the field of music information retrieval (MIR), musical emotion recognition has been a notorious task. An annual competition [MIREX (Music Information Retrieval Evaluation eXchange)](https://www.music-ir.org/mirex/wiki/MIREX_HOME) keeps records of the state-of-the-art (SOTA) performance of various music-related tasks. Currently (2024-09-23), the [latest result from MIREX2020 of the Audio Music Mood Classification](https://www.music-ir.org/nema_out/mirex2020/results/act/mood_report/summary.html) marks the highest classification accuracy of 0.6950 with the best combination of all the advanced deep neural networks. People wonder if this is due to the low reliability of the target labels of emotions.

One possible new direction could be making use of physiological measures in addition to the self-reported ratings. This is what typically has been done in psychology labs on small scales. But with Apple Watch data, together with the Apple Music data, we may see interesting new results.

## Do we just need more data?

Of course, "just more data" won't answer theoretical problems.
However, we still don't have empirical data with sufficient statistical power.

What we can still do in an fMRI lab is to "densely sample" a selected group of participants.
We have proposed a new dataset "ManyMusic🎶" {% cite kim2023cg %} where we plan to collect fMRI scanning of 1,000 full-length creative-commons-licensed music listening.
Please check out <https://manymusic.net> for updates.
The ManyMusic stimuli set has been validated and published {% cite kim2025mms %}.
Currently, we are recording lots of [EEG data](https://manymusic.net/rec) and a lot more to follow!

## Footnotes

<!--


While prediction is different from explanation, reliability and reproducibility can be tested using predictive modeling.
If so, could we accurately predict neurophysiological, bodily, and behavioral responses to better understand how auditory information is transformed to evoke responses?



#### Specificity

#### Reproducibility

How do we even know whether a certain emotion is evoked by certain music?
To establish causation, it is vital to observe a fixed effect of music over multiple repetitions despite varying random factors (e.g., daily mood).

## Does music *"convey"* emotions?

## Is an evoked emotion a percept? Or a representation? A representation of what?

## How do we measure emotions?

## What is emotion anyway?

## What language do people use to describe music-evoked emotions?

## What are the reliable ANS/CNS correlates of music-evoked emotions?

-->
