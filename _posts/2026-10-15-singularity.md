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

First of all, I'm not a trained programmer. I was a GW-BASIC game developer when I was 12, but I've never had any formal training in programming. This has been one of my weaknesses throughout my research career. My codebase has always been clumsy, chaotic, lazy, confusing, and constantly changing.

So, I've been thinking about getting some formal education in programming. I've considered taking online courses, attending boot camps, or even doing a master's degree in computer science. But all of these options take too much time and money, and PhD students and postdocs never have enough of either.

I've been using Claude Code (Opus 5.5) for a month now. I think Codex (GPT-6-astra) still sucks. It keeps trying strange things, burns through a week's worth of tokens in a matter of hours, and still leaves the job unfinished. Claude, on the other hand, has been really helpful and reliable. He's my BFF now! I've finally managed to consolidate my MATLAB naming conventions, which I've been changing every two years for the past decade. (Wait, does that mean I'll have to wait another three years to find out whether these really are the final conventions?)

Anyway, here's the outcome:

### MATLAB naming convention (v2026-10-15)

---

| Form               | Used for                                                                  | Examples                                |
| ------------------ | ------------------------------------------------------------------------- | --------------------------------------- |
| `lowercase`        | functions and class methods                                               | `delayreg`, `lea.main`                  |
| `PascalCase`       | classes; properties, struct fields, table variables, name-value arguments | `Ts`; `job.SampleRateHz`, `stimTs.Data` |
| `camelCase`        | variables of any type, with at least two words                            | `nSubjs`, `fnameLog`, `brainMask`       |
| `UPPER_SNAKE_CASE` | constants                                                                 | `VALID_DATA_TYPES`                      |

---

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
