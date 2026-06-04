# Structural Quality Bar

Review structural quality as part of PR correctness. A PR can implement the requested behavior and still be unacceptable if it leaves the codebase materially harder to maintain.

Look for simplifications that preserve behavior while deleting concepts, branches, helper layers, mode flags, or special cases. Prefer direct, boring ownership over generic machinery that hides a simple invariant.

## Blocker-Level Smells

Treat these as presumptive blockers unless the PR clearly justifies them:

- feature logic scattered across shared or generic paths
- ad hoc conditionals added to already busy flows
- symptom-only fixes that leave the broken invariant unclear
- hidden migrations, magic sentinels, provider/channel IDs, or mode flags in generic core
- unnecessary wrappers, pass-through abstractions, or indirection that does not reduce caller complexity
- `any`, `unknown`, casts, nullable modes, or optionality that obscure the real contract
- repeated conditionals that signal a missing model, helper, or owner module
- file-size growth that makes the changed module harder to scan, especially crossing a local size boundary such as 1000 lines
- sequential orchestration or partial updates where a simple atomic or parallel structure would be clearer

## Output Priority

Prioritize structural findings in this order:

1. structural code-quality regressions
2. missed opportunities for substantial simplification
3. branching or special-case growth
4. boundary, abstraction, or type-contract problems
5. file-size and decomposition concerns
6. modularity or ownership issues
7. legibility and maintainability notes

Prefer a small number of high-conviction findings over a long list of minor cleanup comments. Do not spend review attention on naming or formatting when a larger structural issue is present.

## Review Questions

Ask:

- can the change be reframed so fewer concepts, branches, or helper layers are needed?
- is the logic in the owner module or did it leak into a generic path?
- did the diff make a previously cohesive module more coupled, stateful, or harder to scan?
- does the abstraction earn its keep for callers, or is it just a wrapper?
- did the type boundary get clearer or more ambiguous?
- would a small local refactor clarify the invariant without widening PR risk?

Recommend a larger refactor only when it clarifies an invariant, reduces repeated bug classes, or improves ownership without widening risk. If a refactor would add risk without improving the change class, say so and keep the recommendation smaller.
