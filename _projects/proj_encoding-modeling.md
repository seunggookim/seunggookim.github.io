---
layout: page
title: Encoding modeling
description: "Understanding neural representation<br>Updated: 2024-09-08"
importance: 1
category: methods
giscus_comments: true
related_publications: true
---

Linear modeling with nonlinear transformation of the external information has been widely used to understand how the human brain processes real-world environment
{% cite kim2025rdd kim2024cc kim2023icmpc kim2022fn leahy-kim2021fn %}
.

| <img alt="LEA" src="lea.png" width="600px" data-zoomable> |
| _Fig 1. Overview of Linearized Encoding Analysis (LEA)_ |

## Methodological issues

### Reverse double-dipping
This article {% cite kim2025rdd %} elucidates a methodological pitfall of cross-validation for evaluating predictive models applied to naturalistic neuroimaging data—namely, ‘reverse double-dipping’ (RDD). In a broader context, this problem is also known as ‘leakage in training examples’, which is difficult to detect in practice. RDD can occur when predictive modeling is applied to data from a conventional neuroscientific design, characterized by a limited set of stimuli repeated across trials and/or participants. It results in spurious predictive performances due to overfitting to repeated signals, even in the presence of independent noise. Through comprehensive simulations and real-world examples following theoretical formulation, the article underscores how such information leakage can occur and how severely it could compromise the results and conclusions when it is combined with widely spread informal reverse inference. The article concludes with practical recommendations for researchers to avoid RDD in their experiment design and analysis.

| <img alt="RDD" src="rdd.png" data-zoomable> |
| _Fig 2. Reserve double-dipping: data dips you, twice!_ |

### Time series prediction

| <img alt="SmoothCorr" src="scorr.png" width="600px" style="float" data-zoomable> |
| _Fig 3. Spurious correlation between smooth time series_ |

## Resources

- Kim, 2024-09-07, <b>Linearized Encoding Modeling: a Predictive Analysis Methodology for Music Perception</b>, _Korean Society for Music Perception and Cognition (KSMPC) Summer School 24, Session 3 lecture_.
  [[slides]](https://github.com/seunggookim/ksmpc-ss24-sess3/blob/c17904e35a0648c97227fe48a494380c85703845/docs/2024-09-07_KSMPC-SS_enc_sgKIM_git.pdf)
  [[code]](https://drive.mathworks.com/sharing/cb9d7218-cfa4-4bef-abd2-6f03a6d953dc)
  [[repo]](https://github.com/seunggookim/ksmpc-ss24-sess3)

<!--

## Non-lienar transformation
[..]

## Time-invariant system identification

[..]


## Understanding linear coefficients
[..]

## Predictive modeling and cross-validation

[..]

## Double-dipping and reverse double-dipping
[..]


-->
