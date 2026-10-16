---
name: new-subject
description: Set up the learning kit for a new subject — interview the learner about what they want to learn, their real level, goals, time and tools, then generate subject/subject.md, subject/roadmap.md, subject/exercise-format.md, subject/review-checklist.md and learning/progress.md, and install optional packs and agents. Use when subject/subject.md says NOT CONFIGURED or the learner wants to configure a new subject.
---

# /new-subject

## 0. Safety check
If `subject/subject.md` is already configured (does not contain `NOT CONFIGURED`), warn: this replaces the current
subject. Recommend copying the `learning-kit` template to a new folder instead. Continue only if the learner
explicitly confirms; never touch `learning/journal/` or `learning/knowledge/` of an existing subject.

## 1. Interview (1–2 questions at a time, conversational)
1. **What** do you want to learn, and **why** (job, project, curiosity)?
2. **Current level** — ask for a self-rating, then verify with 2–4 short diagnostic questions of rising difficulty.
   Record the *verified* level, not just the self-rating.
3. **Final goal** — what should you be able to *do* at the end? Push for a concrete, demonstrable outcome
   (a project, an exam, a conversation, a portfolio piece). This becomes the anchor for "why before how".
4. **Time** — hours/week, typical number and length of sessions, any deadline.
5. **Environment & tools** — what you use or want to use. For technical subjects, check what is installed
   (run version commands) and note it.
6. **Learning preferences** — theory-first or hands-on-first, preferred references, language of explanations.
7. **Software project?** — does it involve building software where requirements, architecture and design
   matter? If yes, offer the `software-project` pack.

## 2. Propose, then agree
Present a short proposal and adjust until the learner agrees:
- Phases (5–12) with topics, an **honest** week estimate at their hours/week, and evidence-based exit criteria.
  Interleave theory and practice; start applying to the final project early to keep motivation.
- How exercises are made and checked (see `templates/exercise-format.md` — pick the matching style).
- Review checklist priorities.
- Knowledge categories (3–6).
- Optional subject agents (e.g. a performance coach, a pronunciation coach) — only if clearly useful.

## 3. Write the files
Fill these from `templates/` (in this skill's folder), replacing every placeholder:
- `subject/subject.md` ← `templates/subject.md`
- `subject/roadmap.md` ← `templates/roadmap.md`
- `subject/exercise-format.md` ← `templates/exercise-format.md`
- `subject/review-checklist.md` ← `templates/review-checklist.md`
- `learning/progress.md` ← `templates/progress.md`
Create the practice and project folders named in `subject.md`.

## 4. Packs and agents
- For each chosen pack: copy `packs/<pack>/skills/*` → `.claude/skills/` and `packs/<pack>/agents/*` →
  `.claude/agents/`, then follow the "After installing" steps in `packs/<pack>/README.md`.
- Create agreed subject agents in `.claude/agents/<name>.md` (frontmatter: name, description, tools) and list
  them in `subject.md`.

## 5. Finish
- If the folder is not a git repo, run `git init`.
- Summarize what was created in a short table.
- Tell the learner: **restart `claude`** so new skills and agents load, then say "hi" and run `/plan-week`.
