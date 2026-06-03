# Report Format

Write a concise, decision-ready architecture report. The reader should understand the system vantage point, delegated coverage, candidate deepening opportunities, and which recommendation is strongest.

Use this shape:

```text
## Architecture Review

Scope:
- target repo, subsystem, workflow, or concern
- why this scope is sufficient or insufficient

System Vantage Point:
- target repo role
- adjacent repos, services, packages, or contracts inspected or known
- cross-repo contracts: APIs, schemas, generated clients, events, queues, auth, shared state, or reporting pipelines
- state and workflow ownership
- constraints imposed by adjacent repos or fixed contracts

Delegated Audit Coverage:
- dimension: surfaces inspected, confidence, and gaps

Current Architecture:
- important modules, interfaces, seams, adapters, tests, and cross-repo contracts

Candidates:
- name
- classification: Repo-local | Cross-repo | System-level | Do not localize
- dimension
- files/modules/repos/contracts
- current friction
- deepening opportunity
- locality and leverage gain
- test impact
- risks and tradeoffs
- recommendation strength: Strong | Worth exploring | Speculative
- confidence and evidence

Top Recommendation:
- candidate to explore first and why it beats alternatives

Do Not Build Yet:
- attractive but premature refactors and why

Proof Gaps:
- surfaces not inspected, uncertain system context, or evidence needed
```

Lead with the system-level constraint when a repo-local refactor would hide or worsen the real architecture problem.

Do not propose a detailed new interface until the user chooses a candidate to explore.
