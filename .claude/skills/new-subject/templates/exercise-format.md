# Exercise format — <subject>

Used by `/exercise` and `/review`. Pick and adapt one style below; delete the others.

## Folder layout
`exercises/NN-<topic-slug>/` containing:
- `README.md` — task, requirements, constraints, stretch goal, connection to the final project (mentor writes)
- <checker files — mentor writes>
- <files the learner creates/fills>

## How to check
<exact commands or procedure>

## Exercise types to rotate
- <type> — <description>

---

### Style A — Programming (tests as checker)
- Mentor writes: README, build file (only after the learner wrote one once), **tests**, empty stubs/declarations.
- Learner writes: the implementation.
- Check: build + run tests (e.g. `ctest`, `pytest`, `npm test`); optionally sanitizers / linters.
- Types: implement-from-tests · debug lab (planted bug) · refactor without breaking tests · measure (predict, then benchmark).

### Style B — Language learning
- Mentor writes: README with the task and the grammar/vocabulary targets. The grading rubric is applied when
  grading and not shown before the attempt (the mentor has no memory between sessions, so the targets in the
  README are what grading is based on).
- Learner writes: translations, short texts, dialogues, or records audio and pastes a transcript.
- Check: mentor grades against the rubric (accuracy, grammar points, vocabulary, naturalness), then the learner corrects.
- Types: translate · write about X using grammar Y · role-play dialogue · error correction · dictation from a text.

### Style C — Theory / maths / concepts
- Mentor writes: problem set (graded difficulty).
- Learner writes: solutions with reasoning in `solutions.md`.
- Check: mentor checks reasoning step by step, not just the final answer.
- Types: compute · prove/justify · explain to a beginner · find the flaw in a given argument · apply to a real case.
