# Output

Lead with what changed and whether the final cleanup round is clean.

Every final report must include these facts:

- cleanup result: clean, clean with validation gap, stopped after rejected findings, or blocked by validation failure
- comparison base, reviewed scope, and excluded work
- subagent rounds run and whether the final round was clean
- accepted findings fixed
- rejected findings and short reasons
- validation run or explicit validation gap

Before stopping, account for coverage:

- changed behavior and public contracts: covered, partly covered, or not covered
- dead or redundant connected code: covered, partly covered, or not covered
- ownership, abstraction, wrappers, and type boundaries: covered, partly covered, or not covered
- directly coupled tests, docs, config, fixtures, or mocks: covered, partly covered, not covered, or unavailable
- validation proof: passed, failed then fixed, skipped with reason, or unavailable

Missing coverage belongs in residual risk or validation gaps, not as an implied pass.

Use headings only when they make the response clearer. A short final answer is valid if it still includes the required facts, coverage, validation, and final clean-round result.
