# Learning Kit — User Guide

A personal mentor for learning anything with Claude Code. The mentor teaches with questions, gives you
practice with checkers, reviews your work, quizzes you on what you forget, keeps notes of everything you ask,
and tracks your progress against a roadmap.

---

## 1. Start a new subject (once, ~20 min)

```
copy the folder:   learning-kit  →  my-new-subject      (keep learning-kit untouched as the template)
cd my-new-subject
claude
/new-subject
```

The mentor interviews you: what you want to learn, your current level (with a few check questions),
your final goal, hours per week, tools. It then writes your `subject/` files and a roadmap.
**Restart `claude`** afterwards so new skills/agents load, then run `/plan-week`.

## 2. Every session — just 3 things

| You | What happens |
|---|---|
| Say **"hi"** | Mentor says where you are, today's goal, asks a warm-up question, suggests the next step |
| **Work and ask anything** | Lessons, exercises, reviews. Every real question gets answered **and saved to your notes** |
| Say **"done"** | Journal, progress and weak spots are updated; you get the next step for next time |

You don't need to remember commands — the mentor always suggests the next one. Plain language works:
"teach me X", "give me practice", "check my work", "quiz me", "save this", "I'm done".

💡 Start a **fresh `claude` session for each study session** (or `/clear`). Your progress lives in files, so
nothing is lost, and a fresh session stays fast and focused.

## 3. A typical week (example: 7 hours)

| Session | Time | Flow |
|---|---|---|
| Mon | 2 h | `/quiz` warm-up 10' → `/lesson` 45' → `/exercise` 60' → "done" |
| Wed | 2 h | warm-up → finish exercise → `/review` → fix → "done" |
| Sat | 3 h | warm-up → project work (apply what you learned) → `/review` → "done" |

Start of each week: `/plan-week`. End of each phase: `/checkpoint`.

## 4. Commands

| Command | When |
|---|---|
| `/new-subject` | Once, to set up a subject |
| `/plan-week` | Start of each week |
| `/lesson [topic]` | Learn the next (or a given) topic |
| `/exercise [topic]` | Practice with a checker (tests, answer check…) |
| `/review [path]` | Get feedback on your work — hints, not fixes |
| `/quiz [n]` | Refresh what you might forget |
| `/note` · `/note find X` · `/note review X` | Save / search / revisit your notes |
| `/checkpoint` | "Am I ready for the next phase?" |

**software-project pack** (for subjects where you build software): `/design-lesson`, `/design-doc`, `/trace`
and the `architect` agent — learn to write requirements, architecture, module designs and ADRs.

## 5. Your files

| Path | What | Edit it yourself? |
|---|---|---|
| `subject/subject.md` | Your profile, goals, time, tools, settings | ✅ anytime |
| `subject/roadmap.md` | Phases, topics, exit criteria | ✅ anytime — the mentor follows it |
| `subject/exercise-format.md` | How exercises are built and checked | ✅ |
| `subject/review-checklist.md` | What reviews look for | ✅ |
| `learning/progress.md` | Where you are | mentor updates it |
| `learning/weak-spots.md` | Topics to revisit | mentor updates it |
| `learning/journal/` | One entry per session day | mentor writes it |
| `learning/knowledge/` | **Your notes**: Q&A, summaries, pitfalls, know-how, by topic | ✅ both of you |

The knowledge base is plain Markdown — readable in VS Code, Obsidian or GitHub.

## 6. FAQ

- **The mentor did my work for me.** Say "you broke rule 1" — it will step back to hints.
- **I'm behind schedule / missed a week.** Normal. Tell the mentor or run `/plan-week`; `/checkpoint` can
  adjust the roadmap honestly.
- **Too easy / too hard.** Say so — the mentor adapts. To change it permanently, edit "Current level" in `subject.md`.
- **Back up my progress.** The folder is a git repo: commit `subject/` and `learning/` regularly.
- **Upgrade the kit.** Improve skills in `learning-kit/.claude/`, then copy `.claude/skills/` and `.claude/agents/`
  into your subject folder. Never overwrite `subject/` or `learning/`.

## 7. Customizing

- **Skills** (`.claude/skills/<name>/SKILL.md`): the commands. Edit the instructions in plain English.
- **Agents** (`.claude/agents/*.md`): specialist reviewers. Add subject-specific ones and list them in `subject.md`.
- **Packs** (`packs/<name>/`): optional bundles of skills + agents. Install by copying `packs/<name>/skills/*`
  into `.claude/skills/` and `packs/<name>/agents/*` into `.claude/agents/` (`/new-subject` does this for you).
