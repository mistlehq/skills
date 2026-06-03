# Evidence Standard

## Evidence Classes

Classify every important claim as one of:

- **Fact**: directly supported by inspected evidence.
- **Assumption**: plausible but not directly verified.
- **Inference**: conclusion drawn from facts plus domain reasoning.
- **Report**: user, customer, support, incident, or prior-agent statement not independently verified.
- **Hypothesis**: possible explanation being tested.

Keep provenance close to the claim: command, file, log, trace, timestamp, dashboard, screenshot, report, URL, or conversation context.

## Evidence Strength

Strong evidence usually includes:

- direct reproduction under conditions tied to the issue
- logs, traces, metrics, or runtime state for the affected timeframe
- failing command or test output with environment and inputs
- code, config, or data path that explains the symptom
- recent change correlated with the failure and supported by a mechanism

Weak evidence includes:

- vague reports without timestamps, environment, input, or affected identity
- screenshots without source context
- stale logs, old CI, old comments, or unverified prior conclusions
- correlation without a mechanism
- assumptions from expected architecture rather than inspected behavior
- tests or mocks that only prove a constructed scenario

Weak evidence can still guide investigation, but it must reduce confidence.

## Performance Evidence

For performance, latency, cost, throughput, or resource issues, establish a measurement before diagnosing cause. Prefer baseline/current comparisons, trace spans, query timings, profiler output, queue lag, resource usage, or before/after measurements over anecdotal slowness or log volume.

Logs can explain performance behavior, but they rarely prove magnitude by themselves. Tie performance conclusions to measured impact, affected timeframe, and workload or input size when possible.

## Reproduction And Tests

Try to reproduce or directly observe the symptom when feasible and non-destructive.

Use focused tests when they can represent observed conditions without inventing unsupported state. Treat newly written tests as hypothesis checks. A test strengthens the diagnosis only when its setup is tied to evidence from logs, runtime state, inputs, config, data, docs, or the user report.

Classify test-based evidence as:

- **observed reproduction**: the reported symptom occurs under evidenced conditions
- **mechanism reproduction**: the test shows a codepath can produce the symptom
- **speculative reproduction**: the test uses imagined conditions and only proves that constructed scenario

If tests would be useful but cannot be written or run yet, include them under most useful next evidence rather than presenting them as completed proof.

## Confidence

Use one diagnosis status:

- **Confirmed cause**: evidence directly ties the symptom to a specific cause and alternatives are reasonably ruled out.
- **Likely cause**: evidence supports one cause better than alternatives, but direct proof is incomplete.
- **Narrowed cause**: evidence isolates the failing boundary or small cause set, but not the exact cause.
- **Reproduced symptom**: the symptom was reproduced or observed, but cause is not isolated.
- **Unresolved**: available evidence is insufficient to diagnose.

Do not bury uncertainty. Say when evidence is unavailable, stale, inconclusive, destructive to collect, credential-gated, or not checked.
