# Changelog

Format: [Keep a Changelog](https://keepachangelog.com/) · versions: [SemVer](https://semver.org/).
`/kit-sync push` adds entries under **Unreleased**; move them under a version when tagging a release.

## Unreleased

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
- `GUIDE.md` user guide.
