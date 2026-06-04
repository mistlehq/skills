---
name: github-pr-review-subagents
description: Review live GitHub pull requests with delegated lanes, evidence validation, follow-up delta reviews, and GitHub inline or PR-level publishing. Use when asked for a delegated, parallel, multi-agent, subagent, or follow-up GitHub PR review.
---

## Start
Use live PR state. Run `gh pr view` and `gh pr diff` before reviewing.
Read repo-local review, test, contribution, or maintainer instructions that apply to the changed files.

Apply [DELEGATED-PR-REVIEW.md](DELEGATED-PR-REVIEW.md), [FOLLOW-UP-REVIEWS.md](FOLLOW-UP-REVIEWS.md), [OUTPUT-AND-PUBLISH.md](OUTPUT-AND-PUBLISH.md), [REVIEW-EVIDENCE-STANDARD.md](REVIEW-EVIDENCE-STANDARD.md), and [STRUCTURAL-QUALITY-BAR.md](STRUCTURAL-QUALITY-BAR.md) to every review.

## Reconstruct Scope
Before judging the PR, gather:

- ref: PR number/url, base, and head
- tracker context: linked GitHub issue, Linear, Jira, or other accessible issue context
- stated intent: PR description, linked issue, commits, tests, and author comments
- changed surface: runtime, CLI, provider, channel, docs, tests, config, dependency, or mixed
- change type: bug fix, feature, refactor, config/runtime, dependency, docs, test-only, or mixed
- touched paths: changed files, entrypoints, owners, tests, docs, and config
- affected behavior: production behavior the PR appears to change

## Delegate Review Aspects

The main reviewer owns final judgment, comment wording, and publishing. Use subagents to inspect focused aspects in parallel after scope is reconstructed.

Delegate the smallest concrete lanes that cover correctness, spec, standards, structural quality, and proof. For tiny PRs, the main reviewer may cover lanes inline instead of spawning subagents.

Add focused lanes when the diff needs them:

- backwards compatibility and public contract
- docs, setup, migration, and recovery path
- provider/plugin/channel-specific behavior
- dependency or upstream contract risk

Give each subagent the PR ref, base, head, intent, relevant files, assigned lane, and the required response shape from [DELEGATED-PR-REVIEW.md](DELEGATED-PR-REVIEW.md). Tell subagents they are advisory and must not post comments.

While subagents run, trace the highest-risk path locally. Validate returned findings with [REVIEW-EVIDENCE-STANDARD.md](REVIEW-EVIDENCE-STANDARD.md).

## Review Method

Trace every changed behavior through its production path to the affected boundary.

Use the relevant path:

- runtime: entrypoint -> validation/parsing -> dispatch -> owner module -> shared helper -> persistence/network/runtime boundary
- config/docs: schema/docs -> runtime use -> validation/doctor/migration/recovery path
- provider/plugin/channel: owner implementation first, generic core only when multiple owners need it
- tests: touched tests plus adjacent regression coverage

Use [REVIEW-EVIDENCE-STANDARD.md](REVIEW-EVIDENCE-STANDARD.md) for proof, confidence, and verification failures.

Keep review axes separate until final judgment:

- **Correctness**: does the diff preserve or intentionally change shipped behavior through the real production path?
- **Spec**: does the diff implement the PR's stated intent, and does it avoid unrequested scope creep?
- **Standards**: does the diff follow documented repo conventions and local maintainer instructions?
- **Structural quality**: does the diff keep ownership, abstractions, branching, file size, and type boundaries maintainable?
- **Proof**: do tests, checks, docs, or runtime observations actually cover the changed behavior?

Do not let a pass on one axis mask failure on another. A PR can follow standards but miss the spec, match the spec but break shipped behavior, or pass tests while leaving unacceptable structural risk.

## Review Standard

For all PRs, check ownership, intended behavior, public contract, real production path, narrow proof, user-visible docs/setup, failure path, and structural quality.

Judge by change type:

- bug fix: broken behavior, code-level root cause, cause-level vs symptom-level fix, and whether a small refactor would clarify the invariant without widening risk
- feature: workflow completeness, state model, compatibility, docs, regression coverage
- refactor: preserved behavior, clearer ownership, lower complexity, unchanged contracts
- config/runtime: schema, defaults, runtime use, docs, validation, repair path
- dependency: current upstream contract, version compatibility, approved failure behavior, tests
- docs: accuracy against shipped behavior and no unsupported promises
- test-only: protects real behavior rather than incidental implementation

Apply [STRUCTURAL-QUALITY-BAR.md](STRUCTURAL-QUALITY-BAR.md) before approval, especially for symptom-only fixes, wrong-layer complexity, and changes that make future behavior harder to reason about.

## Follow-Up Reviews

When reviewing after a prior review, apply [FOLLOW-UP-REVIEWS.md](FOLLOW-UP-REVIEWS.md). Default to a delta review, not a fresh full review.

## Findings And Publish

Lead with findings.

Each finding must meet the finding bar in [REVIEW-EVIDENCE-STANDARD.md](REVIEW-EVIDENCE-STANDARD.md).

If there are no blocking findings, say no blocking correctness issues found, strongest proof checked, residual risk or test gaps, and whether the structure is acceptable for this scope.

If verification fails, classify it under proof gaps or residual risk unless it traces to changed code.

Before final judgment, account for coverage and use [OUTPUT-AND-PUBLISH.md](OUTPUT-AND-PUBLISH.md) for output shape, judgment labels, deduplication, and inline vs PR-level routing.
