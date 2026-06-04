# Follow-Up Reviews

A follow-up review is not automatically a full new review. Start from the previous review state, then decide how much to widen.

## Gather Prior State

Before judging the update, collect:

- previous reviewed head SHA, if available
- current head SHA
- prior findings, PR-level comments, inline comments, and author replies
- commits or diff since the previous reviewed head
- checks, tests, docs, or runtime evidence added since the previous review

If the previous reviewed head is unknown, infer it from review comments, commit timestamps, or the last review event when possible. If it cannot be determined, say so and treat confidence as lower.

## Default: Delta Review

Use a delta review when the update appears to address previous feedback without changing the broader PR shape.

Check in this order:

1. Were prior blocking findings fixed at the root cause?
2. Did the fix preserve the original intended behavior?
3. Did the fix add new regressions, wrong-layer complexity, or proof gaps?
4. Were requested tests, docs, or validation added, and do they cover the issue?
5. Are any previous findings still open, partially fixed, or obsolete because the code changed?

For each previous finding, classify status as:

- `resolved`
- `partially resolved`
- `not resolved`
- `superseded`
- `needs re-review`

## Widen To Fresh Review When Needed

Run a fresh lane or full review when the follow-up introduces:

- new user-visible behavior or changed stated intent
- new files, owners, packages, providers, migrations, dependencies, or public contracts
- a different implementation strategy from the one previously reviewed
- substantial structural changes made to satisfy review feedback
- new tests or docs that make behavior claims beyond the original scope
- unresolved uncertainty about which diff was already reviewed

Do not re-review unchanged surfaces just to restate previous conclusions. Do re-check unchanged callers or boundaries when the follow-up fix depends on their invariants.

## Follow-Up Output

Lead with unresolved or newly introduced findings. Then summarize prior-finding status.

Use this compact shape:

```md
## Findings
<new or still-unresolved blocking findings first>

## Prior Findings
- <finding id or short title>: <resolved | partially resolved | not resolved | superseded | needs re-review>

## New Review Coverage
- Delta reviewed:
- Rechecked prior findings:
- Newly widened lanes:
- Not re-reviewed:

## Judgment
<acceptable for merge, no blocking correctness issues found, changes recommended, or blocked by findings>

## Residual Risk
<uncertain prior head, skipped checks, uncovered new surfaces, or remaining test gaps>
```

If every prior finding is resolved, no new scope was introduced, and proof is adequate, a short PR-level comment is enough. If a prior finding remains unresolved, keep the response focused on that finding instead of producing a full new review.
