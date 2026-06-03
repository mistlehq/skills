---
name: diagnose-issue
description: Diagnoses observable technical or operational issues from symptoms, logs, traces, failing commands, screenshots, telemetry, reports, code, config, or runtime state. Use when the user asks to investigate, debug, root-cause, or explain what is happening without implementing fixes.
---

# Diagnose Issue

Use this as a diagnosis-only skill. Produce a defensible explanation of what is happening, how confident the diagnosis is, and which evidence supports or limits that conclusion.

Apply [EVIDENCE-STANDARD.md](EVIDENCE-STANDARD.md), [DIAGNOSTIC-METHOD.md](DIAGNOSTIC-METHOD.md), and [REPORT-FORMAT.md](REPORT-FORMAT.md).

## Boundary

Diagnose observable issues. Do not turn the diagnosis into downstream action unless the user separately asks.

Read files, logs, docs, config, traces, telemetry, reports, screenshots, codepaths, and runtime state. Run non-destructive commands and focused checks when they can clarify the diagnosis.

Do not change production state, deploy, rollback, restart services, clear queues or caches, modify config, edit files, or commit changes unless the user explicitly asks after the diagnosis.

## Intake Alignment

Before case reconstruction, identify the diagnostic target: the concrete symptom, claim, anomaly, or question being investigated.

If the target is ambiguous, inspect only enough supplied context to propose a likely target. Then ask one concise alignment question, or state the assumed target and proceed only when the assumption is low-risk.

A target is clear enough when it names what appears wrong or surprising, where it was observed, when or under what conditions it happened, and what answer would count as progress.

Do not diagnose "the logs" or "the system" broadly. Diagnose a specific claim about them. If evidence points to a nearby failure, use it only when it connects to the target symptom, subject, timeframe, and environment.

## Case Reconstruction

Before judging the issue, gather:

- symptom or claim being investigated
- expected behavior and observed behavior
- affected user, customer, workflow, service, job, command, dataset, or environment
- timeframe, timezone, version, deployment, branch, or run identifier
- severity and blast radius when knowable
- source material: logs, traces, metrics, screenshots, reports, commands, files, PRs, issues, docs, or conversation context
- what has already been tried and what changed recently

If the case cannot be reconstructed from available material, ask one concise question for the missing fact that most blocks diagnosis.

## Evidence Discovery

Infer the right evidence surfaces from the case. Do not rely on a fixed tool list.

Prefer evidence tied to the affected timeframe, environment, input, identity, config, data, codepath, or runtime boundary. Separate directly observed facts from assumptions, stale reports, correlation, and model inference.

Try to reproduce or directly observe the symptom when feasible and non-destructive. Use sandbox tests as hypothesis checks only when their setup is tied to observed evidence.

## Diagnostic Loop

Generate competing hypotheses for non-trivial issues. Test the highest-signal hypothesis first, especially checks that can disprove a plausible explanation quickly.

Trace the failure to the responsible boundary: caller input, user workflow, validation, application logic, dependency, network, persistence, auth, config, deploy, external provider, data shape, timing, or reporting pipeline.

Stop when the diagnosis reaches the strongest support available from the current evidence. Do not over-read weak evidence to produce certainty.

## Delegated Diagnosis

For large, ambiguous, high-severity, or multi-surface issues, optionally delegate bounded evidence checks in parallel using [DIAGNOSTIC-METHOD.md](DIAGNOSTIC-METHOD.md). Subagents are advisory. The main diagnostician owns final judgment and must validate each claim before using it.

## Output

Use [REPORT-FORMAT.md](REPORT-FORMAT.md). Always state diagnosis status, evidence checked, facts, hypotheses considered, conclusion, confidence, proof gaps, and the most useful next evidence.
