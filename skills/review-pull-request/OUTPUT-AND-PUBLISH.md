# Output And Publish

Lead with findings. Omit empty sections only when inline comments plus a short PR-level summary are clearer.

## Coverage

Before final judgment, account for:

- changed behavior: covered, partly covered, or not covered
- spec/intent: covered, partly covered, not covered, or unavailable
- repo standards: covered, partly covered, or not covered
- structural quality: covered, partly covered, or not covered
- executable proof: covered, partly covered, not covered, or unavailable

Missing coverage belongs in residual risk or proof gaps, not as an implied pass. For compact PR-level comments, collapse fully covered lanes into one sentence and expand only partial, missing, or unavailable coverage.

## Shape

```md
## Findings
<blocking findings first; each with anchor or symbol, failure mode, impact, smallest fix>

## Review Coverage
- Changed behavior:
- Spec/intent:
- Repo standards:
- Structural quality:
- Executable proof:

## Judgment
<acceptable for merge, no blocking correctness issues found, changes recommended, or blocked by findings>

## Residual Risk
<skipped checks, uncovered surfaces, unverified assumptions, or remaining test gaps>
```

## Judgment Labels

Every review must end with exactly one judgment label:

- `acceptable for merge`: no blocking findings, no material residual risk, and coverage is adequate for the PR scope
- `no blocking correctness issues found`: no blocking correctness findings, but residual risk, proof gaps, or non-blocking structural concerns remain
- `changes recommended`: non-blocking findings or cleanup should be addressed before merge
- `blocked by findings`: at least one finding should block merge until fixed

Do not soften or combine labels. Use residual risk to explain caveats instead of inventing another judgment state. These are textual judgment labels for the PR-level comment. Do not perform a formal GitHub approval action unless the user explicitly asks.

## Publishing

Publish to the review host by default unless the user asks for dry-run, preview, or local-only review.

Before publishing, merge duplicates into the clearest root-cause finding and keep only findings the main reviewer can defend from direct evidence.

## GitHub Publishing

Route findings by anchor:

- exact changed-line finding: post an inline review comment with `gh api`
- finding without an exact diff anchor: include it in the PR-level summary with file/symbol references

For GitHub pull requests, post inline comments first, then post the PR-level summary with `gh pr comment`. The review is not complete until the host write succeeds or the write failure is reported.
