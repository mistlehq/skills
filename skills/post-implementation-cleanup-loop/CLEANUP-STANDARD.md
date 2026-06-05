# Cleanup Standard

Accept a cleanup finding only when it is grounded in the current diff or directly connected code and preserves intended behavior.

Reject findings that are speculative, stylistic, repo-wide opportunistic cleanup, behavior-changing unless requested, broad rewrites without a concrete ownership improvement, or unsafe because the relevant contract or boundary is unclear.

## Scope

Include non-touched code only when the implementation made it unused, redundant, misleading, or ownership-confused. Prefer connected callers, callees, obsolete helpers, and compatibility leftovers before expanding by pattern.

If shared ownership or a local contract changes, include directly coupled tests, stories, fixtures, harnesses, docs, query/config wiring, and dependent wrappers or mocks.

Do not widen into unrelated files just because the same pattern exists elsewhere. Do not mix cleanup with migrations, dependency upgrades, broad renames, or repo-wide tidying unless the user asked for that broader sweep.

## Boundaries

Prefer deletion over wrapper churn.

Prefer upstream-derived types, scalar parameters, and upstream outputs or errors unless the local layer adds real policy or a stricter contract.

If a boundary already owns ordering, shaping, or state derivation, delete downstream re-derivation.

Before deleting or inlining a wrapper, helper, API, or compatibility path, verify whether it owns an invariant, policy, normalization step, architectural boundary, or future extension point.

If the code crosses a named boundary such as service, handler, controller, repository, adapter, or client, state why that layer no longer owns a real contract before collapsing it.

Do not keep cosmetic abstractions or helper extractions that only move complexity around. Extract helpers or subviews only when they make ownership clearer.

## Test Support Ownership

If cleanup touches setup, assertions, fixtures, harness options, or inspection queries, first decide whether the code is test support or product logic.

Do not move test-only behavior into production-like helpers, service modules, or generic domain modules. If shared test support is justified, place it under an explicit test-support/test-helpers path or give it a test-boundary name.
