# Review Evidence Standard

Treat source, current diff, executable checks, current docs, package types, dependency contracts, and runtime observations as evidence.

Treat PR descriptions, author comments, old CI, old issue reports, and prior behavior claims as leads until verified against current source, commands, docs, or runtime behavior.

## Finding Bar

A publishable finding needs:

- exact changed line when inline-anchorable, or symbol/file reference when not
- concrete failure mode
- impact for users, maintainers, runtime behavior, compatibility, or review confidence
- smallest recommended fix
- proof checked

Do not publish speculative, style-only, duplicated, or unverified findings. Keep valid but unanchorable architectural concerns in the PR-level comment.

When an accepted finding reveals a bug class or repeated pattern, inspect the current PR scope for sibling instances before publishing. Keep the sweep bounded to touched surfaces, adjacent owners, and clear PR-relevant paths. Prefer one root-cause finding with sibling examples over duplicate comments when the same fix addresses them.

When a finding depends on prior behavior or regression history, verify provenance from source, tests, git history, linked issues, prior PRs, or maintainer comments before publishing. Keep original behavior, regressing change, current PR change, and current PR author separate. If provenance is unclear, state the uncertainty as residual risk instead of guessing.

## Confidence

Use high confidence when the finding is directly supported by source, the changed line is identified, the affected path is traced, and proof or contracts confirm the failure.

Use medium confidence when the path and impact are likely but one supporting surface is incomplete, such as missing runtime access, skipped checks, or unavailable dependency docs.

Use low confidence for residual risk, proof gaps, or questions that need author input. Do not turn low-confidence concerns into blocking findings.

## Verification Failures

When a command, check, or runtime verification cannot run, record:

- command or verification attempted
- short failure summary
- whether the failure appears caused by the PR, the environment, credentials, flake, or unknown cause
- how it affects confidence
- next evidence that would raise confidence

Do not report a failed verification as a code finding unless it traces to the changed code.
