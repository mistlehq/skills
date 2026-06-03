---
name: improve-system-architecture
description: Reviews codebase architecture from a system vantage point, including adjacent repos, cross-repo contracts, module depth, seams, test surfaces, and domain locality. Use when the user wants to improve architecture, find refactoring opportunities, simplify shallow modules, improve testability, or understand whether a repo-local cleanup is enough.
---

# Improve System Architecture

Use this as a read-only architecture review and recommendation skill. The goal is to find deepening opportunities that improve locality, leverage, testability, and human or agent navigability.

Apply [LANGUAGE.md](LANGUAGE.md), [DEEPENING.md](DEEPENING.md), [DELEGATED-AUDIT.md](DELEGATED-AUDIT.md), and [REPORT-FORMAT.md](REPORT-FORMAT.md) to every review. Use [INTERFACE-DESIGN.md](INTERFACE-DESIGN.md) only after the user chooses a candidate to explore.

## Boundary

Do not edit files, refactor code, update docs, create ADRs, commit, push, or open a PR. Read files and run non-mutating commands only.

Do not judge a repo's architecture in isolation when behavior, state, contracts, or ownership cross repo boundaries. First reconstruct the system vantage point, then decide whether recommendations are repo-local, cross-repo, system-level, or should not be localized.

## Intake

Identify the target scope before auditing:

- target repo, subsystem, workflow, or concern
- user goal: improve architecture, find refactor candidates, improve tests, simplify modules, clarify ownership, or assess a proposed cleanup
- adjacent repos, services, packages, branches, docs, contracts, or runtime systems the user names or the repo references
- whether the requested scope is sufficient for a meaningful recommendation

If the target or system scope is ambiguous, inspect only enough context to propose a likely scope. Then ask one concise alignment question, or state a low-risk assumption and proceed.

## Topology Reconstruction

Before delegation, gather the current shape:

- app/service/library/monorepo shape, languages, package layout, and major entrypoints
- target repo role in the larger system
- adjacent repos, services, packages, generated clients, schemas, APIs, events, queues, auth, shared state, or reporting pipelines that affect the target
- important domain concepts, ownership, runtime boundaries, and test surfaces
- architecture docs, `CONTEXT.md`, ADRs, subsystem READMEs, and relevant repo instructions

Use repo/domain names when they are established local terms. Use [LANGUAGE.md](LANGUAGE.md) for architecture recommendations.

## Delegated Audit

Delegated audit is mandatory. Apply [DELEGATED-AUDIT.md](DELEGATED-AUDIT.md). Do not produce prioritized recommendations until every audit dimension has current state, coverage, candidate findings, recommendation strength, confidence, and proof gaps.

The mandatory dimensions are:

- system context and cross-repo contracts
- module depth and interfaces
- seams and coupling
- test surface and verification
- domain locality and navigation

The main reviewer owns final judgment. Validate important subagent findings against source evidence before using them. Reject duplicated, speculative, unactionable, or weakly evidenced candidates.

## Recommendation Standard

Prefer candidates that clarify the real system seam, shrink caller knowledge, concentrate change and bugs, make behavior testable through the right interface, and avoid repo-local cleanup that hides a system-level problem.

Classify each recommendation as:

- **Repo-local**: can be done inside the target repo.
- **Cross-repo**: requires adjacent repo or contract changes.
- **System-level**: requires moving ownership, state, workflow, API shape, or runtime responsibility.
- **Do not localize**: a repo-local refactor would hide or worsen a system-level problem.

Use **Do not build yet** for attractive but premature refactors, especially when the system context is incomplete, the seam is hypothetical, or the recommendation would add indirection without leverage.

## Output

Use [REPORT-FORMAT.md](REPORT-FORMAT.md). The default output is a concise text report. An HTML or visual report is a follow-up artifact only when the user asks for it.
