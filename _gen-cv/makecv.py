#!/usr/bin/env python3
"""Generate the CV (PDF) from cv.yml + BibTeX, using cv-mpiea-kim.sty.

Usage (from anywhere):
    python3 _gen-cv/makecv.py              # full CV  -> _gen-cv/build/CV_SeungGoo_KIM.pdf
    python3 _gen-cv/makecv.py --public     # website  -> _gen-cv/build/CV_SeungGoo_KIM_public.pdf
                                           #             and copied to assets/pdf/CV_SeungGoo_KIM.pdf
Options:
    --date "2 November 2026"  date in the footer (default: today)
    --no-copy             with --public, do not copy to assets/pdf/
    --no-amounts          hide funding amounts ('amount' keys in cv.yml)
    --tex-only            write the .tex but do not run LaTeX

Content:      _gen-cv/cv.yml            (all sections except publications)
Publications: _bibliography/papers.bib  (+ _gen-cv/extra.bib), selected by the
              CV-only fields cvgroup, cvnote, cvmark, cvstatus, cvjournal, cvtodo.
Referees:     _gen-cv/referees.yml      (git-ignored; --public prints names only)

Requires: Python 3 with PyYAML; TeX Live with xelatex.
Font: Helvetica Neue (macOS system font; TeX Gyre Heros if missing).

HISTORY
2026-11-02  first version (replaces the Apple Pages CV of 2025-07)
2026-11-02  XeLaTeX + Helvetica Neue (Light name, Medium headings)
2026-11-02  timeline items take "role" ("Current role" if ongoing); warn on unknown keys
2026-11-02  never copy a stale PDF: xelatex passes until refs settle; check PDF is fresh
2026-11-02  .tex finds style + logo via \input@path (builds from any editor)
2026-11-02  own name (meta.me) in Medium in all author lists
2026-11-02  timeline key "amount" (- Funding: ...), hidden with --no-amounts
2026-11-02  dates: publications year only; talks and footer "19 July 2022"
2026-11-02  no year in citations (it is in the year column); talks "(19 July)"
"""
import argparse
import datetime as dt
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

import yaml

GEN = Path(__file__).resolve().parent          # _gen-cv/
REPO = GEN.parent                              # repository root
BUILD = GEN / "build"
MONTHS = "Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec".split()   # for parsing bib months
MONTH_NAMES = ("January February March April May June July August September "
               "October November December").split()                  # for printing
PARTICLES = {"de", "van", "von", "der", "den", "da", "di", "del", "della", "le", "la", "du", "ten", "ter"}
TODOS = []                                     # collected for the summary
ME = None                                      # meta.me in cv.yml, e.g. 'Kim S-G'


def warn(msg):
    print(f"WARNING: {msg}", file=sys.stderr)


# ---------------------------------------------------------------------------
# Text -> LaTeX
# ---------------------------------------------------------------------------
_SPECIAL = {"\\": r"\textbackslash{}", "&": r"\&", "%": r"\%", "$": r"\$",
            "#": r"\#", "_": r"\_", "{": r"\{", "}": r"\}",
            "~": r"\textasciitilde{}", "^": r"\textasciicircum{}"}


def esc(s):
    """Escape LaTeX special characters in plain text."""
    return "".join(_SPECIAL.get(c, c) for c in str(s))


def esc_url(u):
    """Escape a URL for the first argument of \\href."""
    return u.replace("\\", "").replace("%", r"\%").replace("#", r"\#")


_TOKEN = re.compile(
    r"(?P<url>(?:https?|mailto):[^\s()<>]*[^\s()<>.,;:])"
    r"|(?P<doi>doi:\s?(?P<doiid>10\.[^\s()<>]*[^\s()<>.,;:]))"
    r"|(?P<todo>TODO\((?P<todotext>[^()]*)\))"
    r"|(?P<sup>\^(?P<suptext>[*+†]+))"
    r"|(?P<bold>\*\*(?P<boldtext>.+?)\*\*)"
    r"|(?P<ital>\*(?P<italtext>[^*\s][^*]*?)\*)"
)


def tex(s):
    """Plain text with light markup -> LaTeX (see the header of cv.yml)."""
    if s is None:
        return ""
    s = str(s)
    out, pos = [], 0
    for m in _TOKEN.finditer(s):
        out.append(esc(s[pos:m.start()]))
        if m["url"]:
            u = m["url"]
            out.append(rf"\href{{{esc_url(u)}}}{{{esc(u.removeprefix('mailto:'))}}}")
        elif m["doi"]:
            d = m["doiid"]
            out.append(rf"\href{{https://doi.org/{esc_url(d)}}}{{doi:{esc(d)}}}")
        elif m["todo"]:
            TODOS.append(m["todotext"])
            out.append(rf"\cvtodo{{{esc(m['todotext'])}}}")
        elif m["sup"]:
            out.append(rf"\cvmark{{{esc(m['suptext'])}}}")
        elif m["bold"]:
            out.append(rf"\textbf{{{tex(m['boldtext'])}}}")
        elif m["ital"]:
            out.append(rf"\emph{{{tex(m['italtext'])}}}")
        pos = m.end()
    out.append(esc(s[pos:]))
    return "".join(out)


def when(s):
    """'2021-present' -> '2021--Present' (en dash)."""
    s = str(s).strip()
    s = re.sub(r"(\d{4})\s*[-–]\s*(\d{4}|[Pp]resent)", r"\1--\2", s)
    return tex(s).replace("present", "Present").replace(r"--", "--")


def end_dot(s):
    s = s.rstrip()
    return s if s.endswith((".", "?", "!")) else s + "."


# ---------------------------------------------------------------------------
# BibTeX (small parser: enough for papers.bib; values are kept as LaTeX)
# ---------------------------------------------------------------------------
def parse_bib(path):
    text = Path(path).read_text(encoding="utf-8")
    entries, i = [], 0
    while True:
        m = re.compile(r"@(\w+)\s*\{\s*([^,\s]+)\s*,").search(text, i)
        if not m:
            break
        etype, key, j = m.group(1).lower(), m.group(2), m.end()
        if etype in ("comment", "string", "preamble"):
            i = j
            continue
        fields = {}
        while True:
            fm = re.compile(r"\s*([A-Za-z_][\w-]*)\s*=\s*").match(text, j)
            if not fm:
                break
            name, j = fm.group(1).lower(), fm.end()
            if text[j] in "{\"":
                close = "}" if text[j] == "{" else "\""
                depth, k = 0, j
                while True:
                    c = text[k]
                    if c == "{":
                        depth += 1
                    elif c == "}":
                        depth -= 1
                    if (close == "}" and depth == 0 and c == "}") or \
                       (close == "\"" and c == "\"" and k > j and depth == 0):
                        break
                    k += 1
                val, j = text[j + 1:k], k + 1
            else:
                vm = re.compile(r"[^,}\s]+").match(text, j)
                val, j = vm.group(0), vm.end()
            fields[name] = re.sub(r"\s+", " ", val).strip()
            cm = re.compile(r"\s*,").match(text, j)
            if cm:
                j = cm.end()
        entries.append({"type": etype, "key": key, "src": str(path), **fields})
        i = j
    return entries


def split_top(s, sep_regex):
    """Split s by a regex separator, only at brace depth 0."""
    parts, depth, last = [], 0, 0
    for m in re.finditer(r"[{}]|" + sep_regex, s):
        t = m.group(0)
        if t == "{":
            depth += 1
        elif t == "}":
            depth -= 1
        elif depth == 0:
            parts.append(s[last:m.start()])
            last = m.end()
    parts.append(s[last:])
    return [p.strip() for p in parts if p.strip()]


def _first_letter(tok):
    t = re.sub(r"\\[A-Za-z]+\s*|[{}\\\"'`^~]", "", tok)
    return t[:1].upper()


def format_author(name, extra_mark=""):
    """'Kim, Seung-Goo' or 'Seung-Goo Kim' -> 'Kim S-G' (+ marks)."""
    marks = "*" * name.count("*")
    name = name.replace("*", "").strip()
    if name.lower() == "others":
        return "et al."
    parts = split_top(name, r",")
    if len(parts) >= 2:
        last, first = parts[0], parts[-1]
    else:
        words = split_top(name, r"\s+")
        # surname particles: 'Federico De Martino' -> 'De Martino'
        k = next((i for i, w in enumerate(words[1:-1], 1)
                  if w.lower() in PARTICLES), len(words) - 1)
        last, first = " ".join(words[k:]), " ".join(words[:k])
    first = re.sub(r"\s*-\s*", "-", first.replace(".", " "))
    initials = "".join(
        "-".join(_first_letter(h) for h in w.split("-") if h)
        for w in first.split())
    marks += extra_mark
    out = f"{last} {initials}".strip()
    return out + (rf"\cvmark{{{marks}}}" if marks else "")


def highlight_me(s):
    """Wrap your own name (meta.me) in \\cvme{} in an author list."""
    if not ME:
        return s
    return re.sub(r"(?<![\w-])" + re.escape(ME) + r"(?![\w-])",
                  lambda m: rf"\cvme{{{m.group(0)}}}", s)


def month_num(m):
    if not m:
        return 0
    m = m.strip("{} ").lower()
    if m.isdigit():
        return int(m)
    for i, name in enumerate(MONTHS, 1):
        if m.startswith(name.lower()):
            return i
    return 0


def format_pub(e):
    """One bib entry -> LaTeX citation in the CV style."""
    marks = {}
    for item in e.get("cvmark", "").split(","):
        if "=" in item:
            k, v = item.split("=", 1)
            marks[int(k)] = v.strip()
    authors = split_top(e.get("author", ""), r"\s+and\s+")
    alist = [highlight_me(format_author(a, marks.get(i, ""))) for i, a in enumerate(authors, 1)]
    n_star = sum(a.count("*") for a in authors)
    # no date in the citation: the year is in the year column (months only sort)

    title = e.get("title", "").strip()
    if e["type"] == "book":
        s = f"{', '.join(alist)}. \\emph{{{end_dot(title)}}}"
        if e.get("note"):
            s += f" ({e['note']})."
        series = e.get("series", "")
        if series:
            s += f" In {series}" + (f": {e['number']}" if e.get("number") else "") + "."
    else:
        s = f"{', '.join(alist)}. {end_dot(title)}"
        venue = e.get("cvjournal") or e.get("journal") or e.get("booktitle", "")
        vol = re.match(r"\d+", e.get("volume", "") or "")
        num = e.get("number", "")
        pages = (e.get("pages", "") or "").replace("--", "-").replace("-", "--")
        if not e.get("cvjournal"):
            if vol:
                venue += f" {vol.group(0)}"
                if num.isdigit():
                    venue += f"({num})"
            if pages:
                venue += f": {pages}" if vol else f", pp.~{pages}"
        s += f" \\emph{{{venue}}}"
        if e.get("cvstatus"):
            s += f" ({e['cvstatus']})"
        s += "."

    doi = (e.get("doi") or "").strip()
    doi = re.sub(r"^https?://(dx\.)?doi\.org/", "", doi)
    if not doi:
        for k in ("url", "html"):
            m = re.search(r"doi\.org/(10\.\S+)", e.get(k, ""))
            if m:
                doi = m.group(1)
                break
    if doi:
        pre = "Preprint: " if e.get("cvjournal") else ""
        s += rf" {pre}\href{{https://doi.org/{esc_url(doi)}}}{{doi:{esc(doi)}}}"
    elif e.get("url", "").startswith("http") and e.get("cvstatus"):
        # not yet published (no DOI): link to the programme/preprint page
        s += rf" \url{{{esc_url(e['url'])}}}"

    notes = []
    if n_star >= 2:
        notes.append(r"\cvmark{*}Both share first authorship" if n_star == 2
                     else r"\cvmark{*}Shared first authorship")
    if e.get("cvnote"):
        notes.append(e["cvnote"])
    if notes:
        s += " (" + "; ".join(notes) + ")"
    if e.get("cvtodo"):
        TODOS.append(f"{e['key']}: {e['cvtodo']}")
        s += rf" \cvtodo{{{esc(e['cvtodo'])}}}"
    return s


# ---------------------------------------------------------------------------
# Section renderers
# ---------------------------------------------------------------------------
def r_bullets(sec, ctx):
    items = "\n".join(rf"  \item {tex(x)}" for x in sec["items"])
    return f"\\begin{{cvbullets}}\n{items}\n\\end{{cvbullets}}\n"


def r_text(sec, ctx):
    return tex(sec["text"]) + "\n"


TIMELINE_KEYS = {"when", "what", "role", "details", "lines", "amount"}
TALK_KEYS = {"date", "authors", "title", "venue", "note"}


def check_keys(item, known, sec):
    """Warn about keys in cv.yml that the renderer would silently ignore."""
    extra = set(item) - known
    if extra:
        warn(f"ignored key(s) {sorted(extra)} in '{sec.get('title')}': "
             f"{str(item.get('what') or item.get('title'))[:50]}")


def r_timeline(sec, ctx):
    env = "cvcompact" if sec.get("compact") else "cvlist"
    out = [f"\\begin{{{env}}}"]
    for it in sec["items"]:
        check_keys(it, TIMELINE_KEYS, sec)
        body = tex(it["what"])
        if it.get("role"):
            label = "Current role" if str(it.get("when", "")).lower().endswith("present") else "Role"
            body += rf"\cvdetail{{- {label}: {tex(str(it['role']).rstrip('.'))}}}"
        # order under the entry: role, funding, details (project first), lines
        if it.get("amount") and ctx.get("amounts", True):
            body += rf"\cvdetail{{- Funding: {tex(it['amount'])}}}"
        for d in it.get("details", []) or []:
            body += rf"\cvdetail{{- {tex(d)}}}"
        for d in it.get("lines", []) or []:
            body += rf"\cvdetail{{{tex(d)}}}"
        out.append(rf"\cvitem{{{when(it.get('when', ''))}}}{{{body}}}")
    out.append(f"\\end{{{env}}}")
    return "\n".join(out) + "\n"


def _datestr(d):
    """2022-07-19 -> ('2022', '19 July');  2022-07 -> ('2022', 'July');  2022 -> ('2022', '').

    The year itself is shown in the year column, so it is not repeated."""
    d = str(d)
    m = re.match(r"(\d{4})(?:-(\d{1,2}))?(?:-(\d{1,2}))?", d)
    y, mo, da = m.group(1), m.group(2), m.group(3)
    s = ""
    if mo:
        s = MONTH_NAMES[int(mo) - 1]
        if da:
            s = f"{int(da)} {s}"
    return y, s


def r_talks(sec, ctx):
    items = sorted(sec["items"], key=lambda t: str(t["date"]), reverse=True)
    out, prev = ["\\begin{cvlist}"], None
    for t in items:
        check_keys(t, TALK_KEYS, sec)
        y, ds = _datestr(t["date"])
        dpart = f" ({ds})." if ds else ""
        s = f"{highlight_me(tex(t['authors']))}.{dpart} {end_dot(tex(t['title']))} \\emph{{{end_dot(tex(t['venue']))}}}"
        if t.get("note"):
            s += " " + tex(t["note"])
        out.append(rf"\cvitem{{{y if y != prev else ''}}}{{{s}}}")
        prev = y
    out.append("\\end{cvlist}")
    return "\n".join(out) + "\n"


def r_publications(sec, ctx):
    entries = []
    for p in sec["bib"]:
        path = REPO / p
        if path.exists():
            entries += parse_bib(path)
        else:
            warn(f"bib file not found: {p}")
    groups, skip = sec["groups"], set(sec.get("skip", []))
    unassigned = [e for e in entries if e.get("cvgroup") not in groups and e.get("cvgroup") not in skip]
    for e in unassigned:
        warn(f"{e['key']} has no (known) cvgroup -> listed under 'UNASSIGNED'")
    out = []
    order = list(groups.items()) + ([("__none__", "UNASSIGNED")] if unassigned else [])
    for key, title in order:
        g = unassigned if key == "__none__" else [e for e in entries if e.get("cvgroup") == key]
        if not g:
            continue
        g = sorted(g, key=lambda e: (int(re.sub(r"\D", "", e.get("year", "0")) or 0),
                                     month_num(e.get("month"))), reverse=True)
        heading = f"{esc(title)} (\\emph{{N}} = {len(g)})"
        if key == "__none__":
            TODOS.append("bib entries without cvgroup")
            heading = r"\cvtodo{UNASSIGNED: add cvgroup to these bib entries}"
        out.append(rf"\cvsubsection{{{heading}}}")
        out.append("\\begin{cvlist}")
        prev = None
        for e in g:
            y = e.get("year", "")
            out.append(rf"\cvitem{{{y if y != prev else ''}}}{{{format_pub(e)}}}")
            prev = y
        out.append("\\end{cvlist}")
    return "\n".join(out) + "\n"


def count_reviews(sec):
    """Count reviewed manuscripts per journal from the reviews folder (or cache)."""
    folder = Path(os.path.expanduser(sec.get("folder", "")))
    cache = REPO / sec["cache"] if sec.get("cache") else None
    skip_j = set(sec.get("skip_journals", []))
    skip_m = sec.get("skip_if_contains", [])
    if folder.is_dir():
        counts = {}
        for j in sorted(folder.iterdir(), key=lambda p: p.name.lower()):
            if not j.is_dir() or j.name.startswith(("_", ".")) or j.name in skip_j:
                continue
            ids = {re.split(r"[ .\[(]", m.name)[0] for m in j.iterdir()
                   if m.is_dir() and not any(s in m.name for s in skip_m)}
            if ids:
                counts[j.name] = len(ids)
        if cache:
            cache.write_text("# written by makecv.py from " + str(sec["folder"]) + "\n"
                             + yaml.safe_dump(counts, allow_unicode=True, sort_keys=False),
                             encoding="utf-8")
        return counts
    if cache and cache.exists():
        warn(f"reviews folder not found; using {sec['cache']}")
        return yaml.safe_load(cache.read_text(encoding="utf-8"))
    warn("reviews folder and cache not found")
    return {}


def r_reviews(sec, ctx):
    counts = count_reviews(sec)
    ctx["n_reviews"] = sum(counts.values())
    body = ", ".join(f"{tex(j)} ({n})" for j, n in counts.items())
    return f"\\begin{{cvlist}}\n\\cvitem{{{when(sec.get('when', ''))}}}{{{body}}}\n\\end{{cvlist}}\n"


def r_referees(sec, ctx):
    path = REPO / sec["file"]
    if not path.exists():
        warn(f"{sec['file']} not found; referees omitted")
        return "Available upon request.\n"
    refs = yaml.safe_load(path.read_text(encoding="utf-8"))
    out = []
    for r in refs:
        if ctx["public"]:
            out.append(rf"{tex(r['name'])}\par")
            continue
        rows = []
        for label, val in r.get("fields", []):
            v = str(val)
            if label.lower() == "email":
                v = f"mailto:{v}"
            rows.append(rf"\item[{tex(label)}]{tex(v)}")
        out.append(rf"\begin{{cvreferee}}{{{tex(r['name'])}}}" + "\n\\begin{cvfields}\n"
                   + "\n".join(rows) + "\n\\end{cvfields}\n\\end{cvreferee}")
    if ctx["public"]:
        out.append(r"\addvspace{0.3em}{\small\itshape Contact details available upon request.}\par")
    return "\n".join(out) + "\n"


RENDER = {"bullets": r_bullets, "text": r_text, "timeline": r_timeline,
          "talks": r_talks, "publications": r_publications,
          "reviews": r_reviews, "referees": r_referees}


def render_block(sec, ctx):
    t = sec.get("type")
    if t not in RENDER:
        raise ValueError(f"unknown section type {t!r} in {sec.get('title')!r}")
    return RENDER[t](sec, ctx)


# ---------------------------------------------------------------------------
# Document
# ---------------------------------------------------------------------------
def build_tex(cv, ctx):
    meta, basics = cv["meta"], cv["basics"]
    lines = [tex(x) for x in basics.get("lines", [])]
    lines += [rf"{tex(l['label'])}: \href{{{esc_url(l['url'])}}}{{{esc(l['text'])}}}"
              for l in basics.get("links", [])]
    body = [
        rf"\cvtitle{{{tex(meta['name_first'])}}}{{{meta.get('name_footnote_tex', '')}}}"
        rf"{{{tex(meta['name_last'])}}}{{{tex(meta.get('name_suffix', ''))}}}",
        rf"\cvcontact{{{tex(basics['title'])}}}{{{(chr(92) * 2 + chr(10)).join(lines)}}}",
    ]
    for sec in cv["sections"]:
        body.append(rf"\cvsection{{{tex(sec['title'])}}}")
        if "subsections" in sec:
            for sub in sec["subsections"]:
                body.append(rf"\cvsubsection{{{tex(sub['title'])}}}")
                body.append(render_block(sub, ctx))
        else:
            body.append(render_block(sec, ctx))

    name = f"{meta['name_first']} {meta['name_last']}"
    head = rf"""% !TEX program = xelatex
% GENERATED by _gen-cv/makecv.py from cv.yml and BibTeX -- do not edit by hand.
% Style and logo are in the parent folder (_gen-cv/), so any editor can build this.
\makeatletter\def\input@path{{{{../}}}}\makeatother
\documentclass[10pt, a4paper]{{article}}
\usepackage{{cv-mpiea-kim}}
\cvset{{footername}}{{{tex(meta['footer_name'])}}}
\cvset{{date}}{{{esc(ctx['date'])}}}
\cvset{{runninghead}}{{{tex(meta['running_head'])}}}
\cvset{{logo}}{{{meta.get('logo', '')}}}
\hypersetup{{pdftitle={{Curriculum Vitae -- {esc(name)}}}, pdfauthor={{{esc(name)}}}}}
\begin{{document}}
"""
    return head + "\n".join(body) + "\n\\end{document}\n"


def run_latex(texfile):
    """Run xelatex until cross-references (page "x of N") are settled (max 3)."""
    env = dict(os.environ, TEXINPUTS=f"{GEN}{os.pathsep}")
    cmd = ["xelatex", "-interaction=nonstopmode", "-halt-on-error",
           "-file-line-error", texfile.name]
    log, pdf = texfile.with_suffix(".log"), texfile.with_suffix(".pdf")
    for npass in range(1, 4):
        r = subprocess.run(cmd, cwd=texfile.parent, env=env, capture_output=True, text=True)
        txt = log.read_text(errors="replace") if log.exists() else ""
        m = re.search(r"Output written on .*?\((\d+) pages?", txt)
        fresh = pdf.exists() and pdf.stat().st_mtime >= texfile.stat().st_mtime
        if r.returncode != 0 or not m or not fresh:
            errs = re.findall(r"^(?:!|.*:\d+:) .*$", txt, re.M)
            sys.exit(f"LaTeX failed (no fresh PDF) on pass {npass}; see {log}\n"
                     + "\n".join(errs[:5]))
        if npass >= 2 and not re.search(
                r"Rerun to get|undefined references|Label\(s\) may have changed", txt):
            break
    else:
        warn("cross-references still unsettled after 3 passes")
    for pat in ("undefined", "Overfull"):
        n = len(re.findall(pat, txt))
        if n:
            warn(f"{n} '{pat}' message(s) in {log.name}")
    return int(m.group(1))


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--public", action="store_true", help="website version (referee names only)")
    ap.add_argument("--date", default=None, help='footer date, e.g. "2 November 2026"')
    ap.add_argument("--no-copy", action="store_true", help="do not copy the public PDF to assets/pdf/")
    ap.add_argument("--no-amounts", action="store_true", help="hide 'amount' (funding) lines")
    ap.add_argument("--tex-only", action="store_true", help="write .tex only")
    args = ap.parse_args()

    cv = yaml.safe_load((GEN / "cv.yml").read_text(encoding="utf-8"))
    global ME
    ME = cv["meta"].get("me")
    today = dt.date.today()
    ctx = {"public": args.public, "amounts": not args.no_amounts,
           "date": args.date or f"{today.day} {MONTH_NAMES[today.month - 1]} {today.year}"}

    BUILD.mkdir(exist_ok=True)
    stem = (cv["meta"]["output"] + ("_public" if args.public else "")
            + ("_noamounts" if args.no_amounts else ""))
    texfile = BUILD / f"{stem}.tex"
    texfile.write_text(build_tex(cv, ctx), encoding="utf-8")
    print(f"wrote {texfile.relative_to(REPO)}")
    if args.tex_only:
        return

    pages = run_latex(texfile)
    pdf = texfile.with_suffix(".pdf")
    print(f"built {pdf.relative_to(REPO)} ({pages} pages)")
    if "n_reviews" in ctx:
        print(f"reviews counted: {ctx['n_reviews']}")
    if args.public and not args.no_copy:
        dest = REPO / cv["meta"]["public_copy"]
        shutil.copyfile(pdf, dest)
        print(f"copied to {dest.relative_to(REPO)}")
    if TODOS:
        print(f"\n{len(TODOS)} TODO(s) shown in red in the PDF:")
        for t in dict.fromkeys(TODOS):
            print(f"  - {t}")


if __name__ == "__main__":
    main()
