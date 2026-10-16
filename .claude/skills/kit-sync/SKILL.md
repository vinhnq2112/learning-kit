---
name: kit-sync
description: Sync kit improvements between this subject folder and the learning-kit template — push generic improvements of skills/agents/CLAUDE.md/GUIDE.md to the kit, pull kit updates into this subject, and merge conflicts — while keeping subject-specific content out of the kit. Use when the learner says "sync the kit", "push this to the kit", "update from the kit", or after kit-owned files were changed.
---

# /kit-sync [status | push | pull]

Default: `status`. The script is `kit-sync.ps1` in the subject root; run it as
`powershell -NoProfile -ExecutionPolicy Bypass -File kit-sync.ps1 <action> [-Apply] [-KitPath <path>]`
(default kit location: `../learning-kit`).

## Ownership
- **Kit-owned (synced):** `CLAUDE.md`, `GUIDE.md`, `kit-sync.ps1`, all template skills and agents, and installed
  pack skills/agents (they map to `packs/<pack>/…` in the kit).
- **Subject-owned (never synced):** `subject/`, `learning/`, practice and project folders, subject agents, `README.md`.
- **Golden rule:** kit files stay subject-independent. Anything specific to this subject (language, tools,
  project names, paths) belongs in `subject/*.md`, and the kit file only references it.

## status
Run `status` and explain each non-`same` row in plain words:
`subject-changed` → can be pushed · `kit-changed` / `kit-only` → can be pulled · `subject-only` → new file here ·
`conflict` → both sides changed · `deleted` → removed on one side (decide manually).

## push (subject → kit)
1. Run `push` (dry run). For every file to push, show the change: `git diff --no-index <kit file> <subject file>`.
2. **Generality check.** Look for subject-specific content in the change (terms from `subject/subject.md`:
   language, libraries, tools, project folder names, paths). If found, propose a split:
   generic rule in the kit file + specifics in `subject/subject.md` / `exercise-format.md` / `review-checklist.md`.
   Apply the split in the subject after the learner agrees, then re-run the dry run.
3. Ask for confirmation, then run `push -Apply`.
4. Commit both repos: kit `kit: <summary> (from <subject folder name>)`; subject `Sync kit: <summary>`
   (includes `.kit/sync-state.json`).

## pull (kit → subject)
1. Run `pull` (dry run); summarize what each incoming change does (read the diffs).
2. Confirm, run `pull -Apply`, commit the subject repo. If skills or agents changed, tell the learner to
   restart `claude`.

## Conflicts (both sides changed)
Read both versions, merge so every improvement survives, keep it generic, write the **same merged content to
both** files, then run `status` — they show as `same` and the next `push`/`pull -Apply` records them.

## New skill or agent created while learning
If it's useful for any subject: generalize it, then copy it into the kit — `.claude/skills/<name>/` (core) or
`packs/<pack>/skills/<name>/` (pack-specific). From then on the script tracks it. Subject-only agents stay here.
