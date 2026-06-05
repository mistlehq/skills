---
name: review-pull-request
description: Review live GitHub pull requests with delegated lanes, evidence validation, follow-up delta reviews, and GitHub inline or PR-level publishing. Use when asked to review a pull request, PR, GitHub PR, delegated review, parallel review, multi-agent review, subagent review, or follow-up PR review.
---

## Start
Use live PR state: run `gh pr view` and `gh pr diff` before reviewing. Read repo-local review, test, contribution, or maintainer instructions that apply to the changed files.

Apply [DELEGATED-PR-REVIEW.md](DELEGATED-PR-REVIEW.md), [OUTPUT-AND-PUBLISH.md](OUTPUT-AND-PUBLISH.md), [REVIEW-EVIDENCE-STANDARD.md](REVIEW-EVIDENCE-STANDARD.md), and [STRUCTURAL-QUALITY-BAR.md](STRUCTURAL-QUALITY-BAR.md) to every review. For reviews after prior feedback, apply [FOLLOW-UP-REVIEWS.md](FOLLOW-UP-REVIEWS.md) before choosing lanes.

## Scope
Before judging, gather a compact evidence brief:

- ref: PR number/url, base, and head
- tracker context: linked GitHub issue, Linear, Jira, or other accessible issue context
- stated intent: PR description, linked issue, commits, tests, and author comments
- changed surface: runtime, CLI, provider, channel, docs, tests, config, dependency, or mixed
- change type: bug fix, feature, refactor, config/runtime, dependency, docs, test-only, or mixed
- touched paths: changed files, entrypoints, owners, tests, docs, and config
- affected behavior: production behavior the PR appears to change

If reviewing after prior feedback, gather prior review state and decide whether [FOLLOW-UP-REVIEWS.md](FOLLOW-UP-REVIEWS.md) calls for a delta review, fresh lane, or full review before delegation.

## Delegation

The main reviewer owns final judgment, comment wording, and publishing. Use subagents to inspect focused aspects in parallel after scope is reconstructed.

Delegate the smallest concrete lanes that cover correctness, spec, standards, structural quality, and proof. For tiny PRs, the main reviewer may cover lanes inline instead of spawning subagents.

After scope reconstruction, check lane escalation. Add the smallest focused lane for the risk, record why it was added, and do not widen unchanged surfaces just to increase review volume. Escalate for:

- security/privacy: auth, tokens, permissions, sandboxing, secrets, user data, file IO, network boundaries, or CI credentials
- public contract: API, CLI, config schema, plugin/provider interface, persisted data format, backwards compatibility, or recovery behavior
- docs/setup/migration: user-visible docs, setup, migration, rollback, repair path, defaults, or config/runtime docs alignment
- provider/plugin/channel: owner-specific behavior, channel routing, plugin/provider contracts, or shared-core changes that affect multiple owners
- dependency/upstream: dependency upgrades, runtime version changes, external API behavior, package types, or upstream contract risk
- cross-owner behavior: changes spanning multiple modules, packages, providers, channels, or ownership boundaries
- uncertainty: conflicting subagent conclusions, unavailable evidence, low-confidence findings on important paths, or verification that cannot run

Give each subagent the same evidence brief plus relevant files, assigned lane, and required response shape from [DELEGATED-PR-REVIEW.md](DELEGATED-PR-REVIEW.md). Tell subagents they are advisory and must not post comments. While they run, trace the highest-risk path locally.

## Review Method

Trace every changed behavior through its production path to the affected boundary.

Use the relevant path:

- runtime: entrypoint -> validation/parsing -> dispatch -> owner module -> shared helper -> persistence/network/runtime boundary
- config/docs: schema/docs -> runtime use -> validation/doctor/migration/recovery path
- provider/plugin/channel: owner implementation first, generic core only when multiple owners need it
- tests: touched tests plus adjacent regression coverage

Keep review axes separate until final judgment:

- **Correctness**: does the diff preserve or intentionally change shipped behavior through the real production path?
- **Spec**: does the diff implement the PR's stated intent, and does it avoid unrequested scope creep?
- **Standards**: does the diff follow documented repo conventions and local maintainer instructions?
- **Structural quality**: does the diff keep ownership, abstractions, branching, file size, and type boundaries maintainable?
- **Proof**: do tests, checks, docs, or runtime observations actually cover the changed behavior?

Do not let a pass on one axis mask failure on another.

## Review Standard

For all PRs, check ownership, intended behavior, public contract, real production path, narrow proof, user-visible docs/setup, failure path, and structural quality. Apply a lightweight security/privacy screen; escalate when the diff touches auth, tokens, permissions, secrets, user data, file IO, network boundaries, sandboxing, dependency execution, logs, telemetry, CI credentials, or unclear risk.

Judge by change type:

- bug fix: broken behavior, code-level root cause, cause-level vs symptom-level fix, and whether a small refactor would clarify the invariant without widening risk
- feature: workflow completeness, state model, compatibility, docs, regression coverage
- refactor: preserved behavior, clearer ownership, lower complexity, unchanged contracts
- config/runtime: schema, defaults, runtime use, docs, validation, repair path
- dependency: current upstream contract, version compatibility, approved failure behavior, tests
- docs: accuracy against shipped behavior and no unsupported promises
- test-only: protects real behavior rather than incidental implementation

Apply [STRUCTURAL-QUALITY-BAR.md](STRUCTURAL-QUALITY-BAR.md) before approval.

## Findings And Publish

Validate findings with [REVIEW-EVIDENCE-STANDARD.md](REVIEW-EVIDENCE-STANDARD.md). Use [OUTPUT-AND-PUBLISH.md](OUTPUT-AND-PUBLISH.md) for coverage accounting, deduplication, default host publishing, inline vs PR-level routing, and the mandatory single judgment label.
