# Delegated Audit

Delegated audit is mandatory. The main reviewer reconstructs topology and system context first, then delegates one focused audit for each architecture dimension.

## Mandatory Dimensions

### System Context And Cross-Repo Contracts

Inspect the target repo's role in the larger system. Account for adjacent repos, services, packages, generated clients, schemas, APIs, events, queues, auth, shared state, reporting pipelines, deployment constraints, and workflow ownership.

Return whether the requested scope is sufficient and whether repo-local recommendations would miss, hide, or worsen system-level architecture.

### Module Depth And Interfaces

Inspect shallow modules, wide interfaces, pass-through abstractions, duplicated caller knowledge, and interfaces that expose nearly as much complexity as the implementation.

Apply the deletion test to suspected shallow modules.

### Seams And Coupling

Inspect leaky seams, misplaced adapters, one-adapter indirection, duplicated logic across callers, and coupling that crosses repo or runtime boundaries.

Identify where the real system seam appears to live.

### Test Surface And Verification

Inspect whether behavior is testable through the right interface. Flag tests that over-mock, reach through internals, mirror implementation, or cannot cover behavior because the seam is misplaced.

### Domain Locality And Navigation

Inspect whether domain concepts, ownership, and workflow knowledge are concentrated in the right modules and repos. Flag naming drift, scattered concepts, and navigation paths that force readers through many files to understand one concept.

## Required Subagent Output

Each delegated audit must return:

- surfaces searched
- surfaces inspected
- surfaces not covered, with reason
- current architecture shape for the assigned dimension
- candidate findings with file/module evidence
- classification: repo-local, cross-repo, system-level, or do not localize
- recommendation strength: Strong, Worth exploring, or Speculative
- confidence: high, medium, or low
- evidence needed to raise confidence
- do-not-build-yet items

## Main Reviewer Validation

The main reviewer must review every delegated response before using it.

Check:

- did it inspect the required dimension, not just obvious files?
- are uncovered surfaces listed with reasons?
- is system context considered where behavior crosses repos?
- does each candidate include concrete module, interface, seam, test, or contract evidence?
- is confidence justified by coverage and evidence?
- is the recommendation classification correct?

If a response is insufficient, delegate a narrower follow-up or mark the missing coverage as not covered, downgrade confidence, and reduce or remove the claim.

Reject duplicated, speculative, unactionable, purely stylistic, or weakly evidenced candidates.
