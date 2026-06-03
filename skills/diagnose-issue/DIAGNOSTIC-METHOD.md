# Diagnostic Method

## Feedback Signal

Identify the smallest reliable signal that shows whether the symptom is present, absent, changing, or explained. The signal may be a test, command, log query, trace, metric, report, browser/network check, replayed artifact, runtime state, or output diff.

Prefer signals tied to the reported symptom and able to distinguish between competing hypotheses. Sharpen broad or flaky signals before relying on them.

## Hypothesis Loop

For non-trivial issues, keep at least two plausible hypotheses alive until evidence rules them out or one clearly dominates.

For each serious hypothesis, identify:

- what would be true if this hypothesis is correct
- what prediction the hypothesis makes
- what evidence would support it
- what evidence would contradict it
- the cheapest non-destructive check that would reduce uncertainty

A serious hypothesis must be falsifiable. If no evidence could support or refute it, sharpen or discard it.

Prefer checks that can falsify a hypothesis quickly. Avoid collecting broad context after a targeted check would decide the next branch.

## Change And Boundary Analysis

When recent behavior differs from expected or past behavior, inspect the change window:

- commits, PRs, dependency updates, deploys, migrations, config changes, feature flags, provider changes, data imports, scheduled jobs, or workflow changes
- whether the change is tied to the affected timeframe and environment
- whether there is a mechanism from the change to the symptom

Trace the issue to the responsible boundary:

- caller input or user workflow
- validation or parsing
- application logic
- background job or scheduler
- dependency, provider, network, or auth
- persistence, migration, cache, or data shape
- runtime config, deploy, environment, or permissions
- reporting, analytics, billing, or reconciliation pipeline

Name the boundary even when exact root cause remains unknown.

## Delegated Diagnosis

For large, ambiguous, high-severity, or multi-surface issues, optionally delegate bounded evidence checks in parallel.

Good delegation units:

- logs, traces, metrics, or telemetry for the relevant timeframe
- codepath and config that could explain the symptom
- recent changes, deploys, migrations, or dependency updates
- reproduction attempts and focused tests
- external docs, provider behavior, support context, or prior related reports

Give each subagent:

- symptom and timeframe
- known facts
- assigned evidence surface or hypothesis
- required output: evidence checked, facts found, hypotheses supported or refuted, confidence, and proof gaps

Subagents are advisory. Validate returned claims against source evidence before using them in the final diagnosis. Reject speculative, duplicated, style-only, or unverified claims.

## Stopping Rule

Stop when the diagnosis reaches the strongest conclusion available from current evidence, or when the next evidence would require unavailable access, destructive action, excessive cost, or user input. Do not keep exploring after the remaining uncertainty is clearly named.
