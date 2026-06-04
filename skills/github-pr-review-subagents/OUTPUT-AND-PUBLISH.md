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

- `acceptable for merge`: no blocking findings, no material residual risk, and coverage is adequate for the PR scope
- `no blocking correctness issues found`: no blocking correctness findings, but residual risk, proof gaps, or non-blocking structural concerns remain
- `changes recommended`: non-blocking findings or cleanup should be addressed before merge
- `blocked by findings`: at least one finding should block merge until fixed

These are textual judgment labels for the PR-level comment. Do not perform a formal GitHub approval action unless the user explicitly asks.

## Publishing

Before publishing, merge duplicates into the clearest root-cause finding and keep only findings the main reviewer can defend from direct evidence.

Route findings by anchor:

- exact changed-line finding: post an inline review comment with `gh api`
- architectural, cross-file, non-diff, or unanchorable finding: include it in the PR-level comment with file/symbol references
- overall result, proof checked, residual risk, judgment, and broad questions: post one PR-level comment with `gh pr comment`
