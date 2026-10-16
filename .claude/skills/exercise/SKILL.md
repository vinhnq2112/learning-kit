---
name: exercise
description: Create a hands-on practice task in the format defined by subject/exercise-format.md (with tests, rubric or problem set as checker) and guide the learner through it with the hint ladder, never giving the solution. Use after a lesson or when the learner asks for practice.
---

# /exercise [topic]

1. **Topic:** argument, or the current topic in `learning/progress.md`.
2. **Read `subject/exercise-format.md`** and follow it exactly: folder layout, what the mentor creates, what the
   learner creates, how to check, exercise types.
3. **Create** the next `exercises/NN-<topic-slug>/` (or the practice folder from `subject.md`) with the
   README and the checker. **Never write the solution.**
4. **Difficulty:** match the last explain-back score on the topic. Each exercise has a core part (30–60 min)
   and one stretch goal. Rotate exercise types across exercises.
5. **Tell the learner exactly how to check their work** (commands or procedure).
6. **While they work:** use the hint ladder (L1→L4). For error messages, first ask what the message says.
7. **When done:** run `/review` on the result, then record it under "Completed" in `learning/progress.md`.
   Suggest the next step.
