---
name: github-pr-review-subagents
description: Review a GitHub pull request from live PR state by sending focused review aspects to subagents, validating their findings, and posting precise inline comments with gh api plus PR-level comments with gh pr comment. Use when asked for a delegated, parallel, multi-agent, or subagent GitHub PR review.
---

## Start
Use live PR state. Run `gh pr view` and `gh pr diff` before reviewing.
Read repo-local review, test, contribution, or maintainer instructions that apply to the changed files.

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

Delegate only concrete, bounded aspects:

- production path and ownership boundary
- backwards compatibility and public contract
- test coverage and executable proof
- docs, setup, migration, and recovery path
- provider/plugin/channel-specific behavior
- dependency or upstream contract risk

Give each subagent the PR ref, base, head, intent, relevant files, assigned aspect, and required finding shape: file/line or symbol, failure mode, impact, smallest fix, and proof checked. Tell subagents they are advisory and must not post comments.

While subagents run, trace the highest-risk path locally. Validate returned findings against source, diff anchors, tests, docs, and runtime contracts. Reject duplicated, speculative, style-only, or unverified findings.

## Review Method

Trace every changed behavior through its production path to the affected boundary.

Use the relevant path:

- runtime: entrypoint -> validation/parsing -> dispatch -> owner module -> shared helper -> persistence/network/runtime boundary
- config/docs: schema/docs -> runtime use -> validation/doctor/migration/recovery path
- provider/plugin/channel: owner implementation first, generic core only when multiple owners need it
- tests: touched tests plus adjacent regression coverage

Use source, executable checks, current docs, package types, and dependency contracts as proof. Treat PR comments, old CI, and old behavior reports as hints until verified.

## Review Standard

For all PRs, check:

- correct ownership boundary
- intended public/backward-compatible behavior
- clear invariant, workflow, or contract
- implementation path traced through the real production path
- proof at the narrowest layer that would fail for the regression
- docs/setup/examples when user-visible behavior changes
- explicit runtime failure or established repair path
- no broad special cases, hidden migrations, magic sentinels, or provider/channel IDs in generic core

Judge by change type:

- bug fix: broken behavior, code-level root cause, cause-level vs symptom-level fix, and whether a small refactor would clarify the invariant without widening risk
- feature: workflow completeness, state model, compatibility, docs, regression coverage
- refactor: preserved behavior, clearer ownership, lower complexity, unchanged contracts
- config/runtime: schema, defaults, runtime use, docs, validation, repair path
- dependency: current upstream contract, version compatibility, approved failure behavior, tests
- docs: accuracy against shipped behavior and no unsupported promises
- test-only: protects real behavior rather than incidental implementation

Call out symptom-only fixes, wrong-layer complexity, and changes that make future behavior harder to reason about. Recommend a larger refactor only when it clarifies an invariant, reduces repeated bug classes, or improves ownership without widening risk; if the refactor adds risk without improving the change class, say so.

## Findings And Publish

Lead with findings.

Each finding must include:

- file and changed line when anchorable, or symbol when not anchorable
- concrete failure mode
- impact
- smallest recommended fix

If there are no blocking findings, say no blocking correctness issues found, strongest proof checked, residual risk or test gaps, and whether the structure is acceptable for this scope.

If verification fails, say what was attempted, the shortest useful failure summary, whether it appears caused by the PR or by the environment, and how it affects confidence. Do not report it as a code finding unless it traces to the changed code; otherwise include it under proof gaps or residual risk.

Before publishing, merge duplicates into the clearest root-cause finding, downgrade unanchorable valid concerns to PR-level feedback, and keep only findings the main reviewer can defend from direct evidence.

Route findings by anchor:

- exact changed-line finding: post an inline review comment with `gh api`
- architectural, cross-file, non-diff, or unanchorable finding: include it in the PR-level comment with file/symbol references
- overall result, proof checked, residual risk, judgment, and broad questions: post one PR-level comment with `gh pr comment`
