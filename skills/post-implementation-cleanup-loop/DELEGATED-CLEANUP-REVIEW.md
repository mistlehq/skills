# Delegated Cleanup Review

The main agent reconstructs scope and stable behavior first, then delegates focused cleanup review lanes. Delegation is advisory only: subagents must not edit files, commit, push, open PRs, or run a separate review workflow unless explicitly assigned.

Use the smallest set of lanes that covers the current branch/worktree scope. Every complete round must account for:

- changed behavior and public contract stability
- dead code, stale compatibility paths, and redundant connected code
- ownership, abstraction, wrapper, and type-boundary simplification
- directly coupled tests, fixtures, docs, config, generated wiring, and mocks
- validation proof and skipped validation gaps

Split lanes by ownership or cleanup concern. Avoid widening unchanged surfaces just to increase review volume. The main agent may cover a tiny lane inline only after at least one subagent cleanup review runs for the round; record that coverage in the final report.

Give each subagent the same cleanup evidence brief:

- comparison base and reviewed scope
- stable behavior and public contracts that must not change
- touched files, changed behavior paths, and directly connected non-touched code
- cleanup boundary and known unrelated work excluded
- validation already run or available
- assigned lane and required response shape

Each delegated response must include:

- lane reviewed
- surfaces inspected: files, symbols, docs, tests, configs, commands, or runtime paths
- surfaces not covered, with reason
- accepted/actionable findings, each with file/line or symbol, cleanup reason, behavior-preservation argument, smallest fix, and validation to rerun
- rejected cleanup ideas with one-line reasons
- confidence: high, medium, or low
- evidence needed to raise confidence

## Response Review

Before using a delegated finding, the main agent must check:

- did the subagent evaluate the lane against the shared evidence brief?
- did it inspect the right changed and directly connected code paths?
- are uncovered surfaces listed with reasons?
- is confidence justified by coverage and evidence?
- does each accepted finding preserve stable behavior and stay within the cleanup boundary?
- does the proposed fix improve ownership, deletion, duplication, control flow, data flow, or validation clarity?
- is the smallest validation to rerun concrete and relevant?

If a response is insufficient, either run a narrower follow-up or mark the lane as partially covered, downgrade confidence, and avoid treating that lane as a clean-round pass.
