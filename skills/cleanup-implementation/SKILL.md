---
name: cleanup-implementation
description: Clean up a working implementation through repeated behavior-preserving review and fix rounds until no accepted cleanup findings remain. Use when a branch or worktree needs post-implementation cleanup, refactoring, de-duplication, dead-code removal, or ownership simplification without behavior changes.
---

# Cleanup Implementation

Apply [DELEGATED-CLEANUP-REVIEW.md](DELEGATED-CLEANUP-REVIEW.md), [CLEANUP-STANDARD.md](CLEANUP-STANDARD.md), and [OUTPUT.md](OUTPUT.md) to every cleanup loop.

## Goal

Improve the shape of a working implementation without changing intended behavior.

- Treat the target as the full branch plus working tree relative to the comparison base, not just the last commit.
- If unrelated work exists, narrow to the files and commits matching the request and say what was excluded.
- Stop when remaining ideas are consciously rejected as low-value, speculative, behavior-risky, or out of scope.

## Cleanup Order

1. delete dead code, stale branches, unused helpers, and compatibility leftovers
2. collapse duplicated paths into one clear owner
3. remove wrappers, mirror types, forwarding layers, and repeated wiring that do not enforce a real invariant, create a stable boundary, or perform precise normalization
4. simplify control flow, data flow, and state transitions
5. extract helpers or subviews only when they make ownership clearer
6. align with current repo conventions only if scope stays tight

## Round Structure

Before the first round, state the stable behavior, comparison base, branch/worktree scope, cleanup boundary, structural improvement, non-touched code included under [CLEANUP-STANDARD.md](CLEANUP-STANDARD.md), and smallest validation needed.

Each cleanup round:

1. gather a cleanup evidence brief with touched files, changed behavior, directly connected code, and validation available
2. run focused subagent cleanup reviews using [DELEGATED-CLEANUP-REVIEW.md](DELEGATED-CLEANUP-REVIEW.md)
3. verify every subagent finding against [CLEANUP-STANDARD.md](CLEANUP-STANDARD.md) in the real code path
4. apply only accepted fixes
5. rerun focused validation for changed behavior or ownership boundaries
6. rerun another cleanup round if code changed or accepted findings remain

## Subagents

Use subagents only for review. Keep the main agent responsible for final judgment, integration, all file edits, validation, and final reporting.

## Validation And Stop

After accepted fixes, run the smallest validation that proves behavior stayed stable. If validation fails, fix the failure or revert the cleanup that caused it, then rerun validation and another subagent review round.

Stop only when:

- a complete, coverage-accounted subagent review round reports no accepted/actionable cleanup findings, and
- focused validation for the final changes passes or the remaining validation gap is explicitly reported.

## Report

Use [OUTPUT.md](OUTPUT.md).
