# Interface Design

Use this only after the user chooses an architecture candidate to explore.

## Frame The Candidate

Before proposing interfaces, restate:

- the current module, seam, or cross-repo contract
- what should move behind the interface
- dependency category from [DEEPENING.md](DEEPENING.md)
- repo-local, cross-repo, or system-level classification
- constraints any design must satisfy
- tests that should survive after the implementation changes

## Generate Alternatives

Produce at least three meaningfully different interface designs. They should vary by seam placement, caller knowledge, adapter strategy, default use case, or cross-repo ownership.

Each design must include:

- interface shape, including invariants, ordering, error modes, and config
- example caller usage
- what implementation detail it hides
- dependency and adapter strategy
- expected test surface
- locality and leverage tradeoffs
- system-level consequences if the seam crosses repos

## Recommend

Compare the designs by depth, locality, leverage, testability, and system fit. Recommend one design or a hybrid. Do not present a neutral menu when evidence supports a stronger choice.
