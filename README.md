# Learning Kit

A reusable Claude Code kit that turns Claude into a personal learning mentor for any subject:
Socratic lessons, exercises with checkers, teaching reviews, spaced-repetition quizzes, an automatic
knowledge base of everything you ask, and progress tracking against a roadmap.

**This folder is the template.** Copy it for each new subject, open `claude` in the copy, run `/new-subject`.

👉 Read **[GUIDE.md](GUIDE.md)** — setup, the 3-step session, a typical week, commands, FAQ.

```
learning-kit/
├── CLAUDE.md               # mentor rules (subject-independent)
├── GUIDE.md                # how to use the kit
├── .claude/
│   ├── skills/             # new-subject, plan-week, lesson, exercise, review, quiz, note, checkpoint
│   └── agents/reviewer.md  # generic reviewer, driven by subject/review-checklist.md
├── packs/
│   └── software-project/   # optional: design-lesson, design-doc, trace, architect agent
├── subject/                # filled by /new-subject
└── learning/               # your progress, weak spots, journal, knowledge base
```
