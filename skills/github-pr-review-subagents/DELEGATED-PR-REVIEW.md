# Delegated PR Review

The main reviewer reconstructs PR scope into an evidence brief, then delegates focused review lanes. Delegation is mandatory for non-trivial PRs and advisory only: subagents must not post review comments.

Subagents inspect code, docs, tests, contracts, and runtime evidence directly. They must not delegate their lane to another review workflow, reviewer agent, or automated review tool unless the main reviewer explicitly assigns that task.

Use the smallest set of lanes that covers the diff. Always account for correctness, spec, standards, structural quality, and proof, even if one lane is handled by the main reviewer instead of a subagent.

After reconstructing scope, the main reviewer checks lane-escalation triggers from `SKILL.md`. Escalated lanes must name the triggering risk and stay scoped to the files, contracts, docs, checks, or runtime paths needed to cover that risk.

Each delegated response must include:

- lane reviewed
- escalation reason, if this was an escalated lane
- surfaces inspected: files, symbols, docs, issue/spec sources, commands, or checks
- surfaces not covered, with reason
- findings, each with file/line or symbol, failure mode, impact, smallest fix, and proof checked
- confidence: high, medium, or low
- evidence needed to raise confidence
- PR-level concerns that are valid but not inline-anchorable

## Response Review

Before using a delegated finding, the main reviewer must check:

- did the subagent evaluate the lane against the shared evidence brief?
- did the subagent inspect the right files, docs, contracts, and changed paths for the lane?
- if escalated, does the response cover the triggering risk rather than a broad re-review?
- are uncovered surfaces listed with reasons?
- is confidence justified by the coverage and evidence?
- does each finding point to a concrete failure mode, not a vague concern?
- is the impact real for this PR's stated intent or changed behavior?
- is the suggested fix the smallest fix that preserves the intended scope?
- can the finding be anchored to a changed line, or should it be PR-level feedback?

If a response is insufficient, either run a narrower follow-up or mark the lane as partially covered, downgrade confidence, and avoid implementation-ready claims from that response.

## Lane Prompts

Correctness and behavior: trace changed behavior through production entrypoints, ownership modules, shared helpers, and runtime boundaries. Look for broken behavior, compatibility regressions, error handling gaps, state-model mistakes, and wrong-layer fixes.

Spec and intent: compare the diff to PR text, linked issues, tracker context, commits, tests, and author comments. Report missing requirements, partial implementations, unrequested scope creep, and behavior that appears to contradict the stated intent.

Standards: search for applicable instruction and standards sources before reviewing the lane. Common sources include root or nested `AGENTS.md`, `CONTRIBUTING.md`, `CONTEXT.md`, `CONTEXT-MAP.md`, subsystem `README.md` files, `docs/adr/`, `STYLE.md`, `STANDARDS.md`, `STYLEGUIDE.md`, review guides, maintainer instructions, `.editorconfig`, eslint/biome/prettier config, `tsconfig`, package scripts, CI, and generated-code rules. Report hard violations separately from judgment calls. Do not duplicate what deterministic tooling already proves unless the tooling is not run or does not cover the changed path.

Structural quality: apply `STRUCTURAL-QUALITY-BAR.md`. Look for maintainability regressions, wrong ownership, unnecessary indirection, branching growth, file-size pressure, hidden invariants, and type-boundary drift.

Proof: inspect touched tests, adjacent regression coverage, CI/local commands, docs/examples, and runtime verification. Ask whether the narrowest failing check would catch the changed behavior if it regressed.
