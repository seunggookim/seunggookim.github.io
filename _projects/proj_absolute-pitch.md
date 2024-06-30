---
layout: page
title: Absolute pitch
description: Is it a musical gift or a musical curse?
importance: 3
category: music
giscus_comments: false
---
# **WARNING: STILL IN PREPARATION** #

## What is absolute pitch?
In musical scientific literature, absolute pitch (commonly known as "perfect pitch") is defined as an ability to recognize the name of pitch chroma (in a cyclic musical scale) of a given pitch without an external reference.
This is opposed to "relative pitch", which is also a musical pitch processing skill to recognize the name of pitch chroma with an external reference. For example, when the "Do" is given as a pitch, for several minutes (or hours in some cases), one with a good relative pitch can easily identify or sing other chromas such as "Sol-sharp", "Mi-flat", or "Ti".

In a different context (e.g., psychoacoustics), "absolute pitch" could mean simply a fundamental frequency of a pitch in an absolute sense (e.g., 440 Hz) and relative pitch means a difference (e.g., 440 - 220 = 220 Hz).
However, the recognition of pitch chroma has been considered an essential aspect in the musical context. But what is a pitch chroma? 
In a scientific notation of a musical pitch (e.g., "A4", which corresponds to 440 Hz in a "concert" tuning), pitch chroma is noted in alphabets with a sharp of a flat (C, C#, D, D#, E, ..., A, B♭, B) and pitch height is noted in numbers (0, 1, 2, ...). 
Importantly, pitch chroma is cyclic (C, D, E, ..., A, B, C, D, E, ...) whereas pitch height is linear (the first octave, the second octave, ...). See *Fig 1* for illustration. 

| ![pitch-chorma-height](pitch-chroma-height.png#center) |
| *Fig 1. Pitch chroma and pitch height. Note C3 and C4 in red. When you go one octave up, you get the same pitch chroma "C", but the pitch height is increased by one.* |

\
In popular culture, this is often used as a prop of a musical prodigy.
While having absolute pitch can be highly beneficial for musical composition and conduction, it can be detrimental for on-the-fly transposition, which may be needed for performers [(Miyazaki 2004)](https://doi.org/10.1111/j.1468-5584.2004.00260.x). 
Even more, ones with absolute pitch can be easily irritated by imprecisely tuned tones [(Rogenmoser et al., 2020)](https://doi.org/10.1016/j.cortex.2020.11.020).

In Western scientific literature, absolute pitch has been discussed almost exclusively in the context of the Western music scale (12-tone-equal-temperament; 12-TET, which is dividing one octave into equal 12 intervals).
<!--
HOWEVER,...
(and its training), any training on a musical scale with fixed fundamental frequnecies is expected to create absolute pitch.
-->

## I can sing my favorite song from the heart. Do I have absolute pitch?
A similar phenomenon exists where a specific pitch can be recalled without an external reference.
Often, such a member can be obtained without formal musical training but only with extensive exposure (e.g., music listeners who remember the first pitch of a favorite song or engineers who absolutely remebers a test tone [1 Khz]).
Some musicians with good relative pitch and very good auditory working memory may be behaviourally indistinguishable from absolute pitch listeners, as indicated in a study where auditory working memory predicted "absolute pitch learning" in adulthood [(Van Hedger et al., 2015)](https://doi.org/10.1016/j.cognition.2015.03.012). 
However, given that the absolute pitch listeners recognize pitch chroma without additional relative pitch computation, the perceptual process of absolute pitch seems to be distinctive from such a case. 
In [Kim & Knösche (2017)](https://doi.org/10.3389/fnins.2017.00557) [[PDF]](../../assets/pdf/journalpapers/Kim.2017-10-06.FNsci.pdf), we proposed to distinguish the former as the absolute memory of pitch (i.e., without separation of height and chroma) and the latter as the absolute perception of pitch chroma. 


## How do ones with absolute pitch processe a pitch differently than ones without?
### Behaviours
Behavioural responses have been tested and analyzed in a controlled setting. Typically, random tones (either in musical instruments or sine waves) are presented for multiple pitch heights and pitch chroma, and a participant gives an identification (either only pitch chroma or as well as pitch height) as soon as possible.
The performance of this 12-class classification has been rather inconsistently measured across studies. 
Most commonly, a correct rate and mean absolute error have been used. 
In some studies, small errors (1 semitone) were ignored in computing correct rates without justification.

Another interesting behavioural aspect of absolute pitch is the pitch height (octave) confusion.
That is, many musicians with absolute pitch made mistakes in recognizing the pitch height of an unfamiliar timbre (e.g., sine wave) at a similar level as musicians without absolute pitch.

Also interestingly, many other fundamental perception do not seem to differ between musicians with and without absolute pitch. For example, frequency discrimination, gap detection (temporal resolution), and interaural time difference discrimination (i.e., spatial resolution) were found indifferent ([Waka et al., 2002](https://doi.org/10.1250/ast.23.77); [Kim & Knösche, 2016](https://doi.org/10.1002/hbm.23254); [Leite-Filho et al., 2023](https://doi.org/10.3389/fnins.2023.1151776)).
This suggests that superior peripheral auditory processing is not necessary for absolute pitch (i.e., it is not the "ear" but the cortex) unlike the suggestion 


### M/EEG
ERP
Peter, Jan: N1, P2, ...

### fMRI
BOLD
Tonotopy


## Do ones with absolute pitch have different brain structures?
### Macroscopic findings


### Microscopic findings
In [Kim & Knösche (2016)](https://doi.org/10.1002/hbm.23254), we found higher intracortical myelination (indicated by lower T1 values) in the right planum polare (the anterior part of the supratemporal plane) of musicians with absolute pitch than without.
The higher intracortical myelination suggests a suppression of neural plasticity.
Given the (near-)necessity of the early onset of musical training in developing absolute pitch, the increased myelination could contribute to the preservation of the pitch chroma template that the absolute pitch listeners utilize, while it remains unclear whether this is an effect of training or a reflection of genetic predisposition.

### Lesion cases

## Can adults acquire absolute pitch?

## Computational perspectives
Algorithmically, the recogniztion of pitch chroma requires:
1. Extraction of pitch
2. Classification of pitch chroma

One might imagine the preservation of the absolute frequency information from the peripherals (i.e., knowing which hair cell fires; or even which inferior collicolus neuron fires [REF:ROSS](REF)). 
However, the extraction of pitch does not solely rely on the spatial coding but also the temporal coding. 
That is, if this idea were true, absolute pitch would be useless for missing harmonics or iterated-random-noise, which is not true.




