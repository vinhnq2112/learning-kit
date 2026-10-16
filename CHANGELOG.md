# Changelog

Format: [Keep a Changelog](https://keepachangelog.com/) · versions: [SemVer](https://semver.org/).
`/kit-sync push` adds entries under **Unreleased**; move them under a version when tagging a release.

## Unreleased

## 0.1.0 — 2026-10-16

### Added
- **Scaffold levels** for practice (`CLAUDE.md` rule 9, `/exercise`): starter material with numbered `TODO`
  steps, pseudocode and `YOU DECIDE` choices that fades S3 Guided → S2 Outline → S1 Spec → S0 Blank as the
  learner improves. Levels per topic are tracked in `learning/progress.md`; "more help" / "less help" changes
  them. `/review` and `reviewer` check `YOU DECIDE` answers; `/checkpoint` needs S1/S0 evidence; templates
  describe each level per exercise style; `subject.md` gets a **Scaffolding** rule for project work.
- "Language & writing style" rules in `CLAUDE.md`: plain words, short sentences, define terms first, one
  meaning only — for everything the mentor and agents write. `reviewer` and `architect` agents follow them;
  subject template gets a **Language** field.

## 0.0.1 — 2026-10-16
First release.

### Added
- Subject-independent mentor rules (`CLAUDE.md`): hint ladder, Socratic teaching, explain-back scoring,
  evidence over opinion, guided next steps, automatic knowledge capture, session start/end protocol.
- Core skills: `/new-subject`, `/plan-week`, `/lesson`, `/exercise`, `/review`, `/quiz`, `/note`, `/checkpoint`,
  `/kit-sync`.
- `reviewer` agent driven by `subject/review-checklist.md`.
- Subject templates: subject profile, roadmap, exercise format (programming / language / theory styles),
  review checklist, progress.
- `software-project` pack: `/design-lesson` (design track D1–D12 with annotated *thumbgen* examples),
  `/design-doc`, `/trace`, `architect` agent.
- `kit-sync.ps1`: status / push / pull between a subject and the template, dry run by default, last-sync hash
  state with conflict detection, line-ending-insensitive comparison.
- Kit location: `../learning-kit` if present, otherwise an automatically managed clone in `~/.learning-kit/`
  from the URL in `kit.json` — subjects work on any machine with only their own repo cloned.
- `kit-sync.ps1 check`: newer kit release notice at session start.
- GitHub template-repository workflow for creating new subjects.
- `GUIDE.md` user guide.
