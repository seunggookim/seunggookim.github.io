---
layout: page
title: singularity—the future is wow ✨
description: after using Claude Code for one month
importance: 2
tags: nerd, code
giscus_comments: true
related_publication: false
---

 > _“There are only two hard things in computer programming: cache invalidation and naming things.”_ (Phil Karlton — one of the architects of the original Netscape Navigator browser, 1996)

First of all, I'm not a trained programmer. I was a GW-BASIC game developer when I was 10, and I never had any formal training in coding. This has been my one of the weaknesses during my research career. My code has been always clumsy, chaotic, lazy, confusing, and constantly changing.

So I have been thinking about getting a formal education in programming. Thought about taking online courses, boot-camps, or even doing a master program in computer science; but all takes too much time and money, and PhD students and postdocs always have no time and no money.

I have been using Claude Code (Opus 5.5) for one month now. I think Codex (GPT-6-astra) still sucks; trying something strange all the time, and used all week-worth tokens in hours; and the job is unfinished. Claude has been really helpful and reliable. I was finally able to consolidate my MATLAB naming convention that has been changed every 2 years over the last 10 years (wait, this means I'll have to wait and see for 3 years from now to know if this is really the final.).

Anyway, here's the outcome:

### MATLAB naming convention (v2026-10-15)
------

| Form | Used for | Examples |
|---|---|---|
| `lowercase` | functions and class methods | `delayreg`, `lea.main` |
| `PascalCase` | classes; properties, struct fields, table variables, name-value arguments | `Ts`; `job.SampleRateHz`, `stimTs.Data` |
| `camelCase` | variables of any type, with at least two words | `nSubjs`, `fnameLog`, `brainMask` |
| `UPPER_SNAKE_CASE` | constants | `VALID_DATA_TYPES` |

------

- **Functions**: all lowercase without underscores, verb first, ideally no more than two words. Group them in namespace folders (`+name/`) instead of prefixes. Within a namespace, call each other by full name (`mc.<name>(...)`) or after `import mc.*`; helpers in `+mc/private/` need no qualifier. A namespace function may share its name with a MATLAB function (`mc.load`), except helpers in `private/` and functions brought in with `import`, which take precedence over MATLAB's own; keywords (`iskeyword`) are never allowed.
- **Variables**: camelCase whatever the type (including structs, tables and objects: `encMdl`, `stimTbl`), and at least two words, so a variable never looks like a function (`fmriData`, not `data`). Common first words: `n` (count), `i`/`j` (index), `is`/`has` (state), `fname`/`dname` (file/directory name). Exceptions: loop counters (`i`, `j`, `k`), the standard input struct `job` of job-style functions (`job = lea.main(job)`), and mathematical symbols that follow the paper's notation (`X`, `Y`, `Cxx`, `Bhat`).
- **Classes, properties and fields**: classes in PascalCase; properties, struct fields, table variable names and name-value arguments in PascalCase, as in MATLAB's own classes.
- **Logical flags**: a _state_ is `is`/`has` + adjective or past participle (`isDone`, `isZscored`, `hasMask`); an _option_ is a verb phrase without a prefix (`job.Zscore = true`, `job.SavePred`, `job.KeepNull`), never `Is`/`Do` + verb. If the verb is ambiguous, choose a more specific one (`SaveFigs`, not `Plot`).
- **Constants**: UPPER_SNAKE_CASE, the only identifiers with underscores (besides the dated script names).
- **Layout**: help text at most 80 characters wide, code at most 120.

I really feel like this is it! 😃 So, the one of the hardest things in programming is solved! (at least for me). Now I can (automatically) refactor all of my 2000 random utility functions that I wrote over the last decades so that everything is in this new convention. This is the singularity! The super-intelligence is here! 🤖

**References**

1. [Kai Lentit. (2026). Hyperoptimized Engineer 2026.](https://www.youtube.com/watch?v=MhEL9cvLxQE)

2. [m-flo. (2014). "Flashback to 21st Century", Future Is Wow.](https://music.apple.com/us/song/flashback-to-21st-century/830101648)