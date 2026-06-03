# Report Format

Write concise durable reports. The reader should understand what was checked, what is known, what is inferred, what remains uncertain, and which evidence would most reduce uncertainty.

Use this shape:

```text
## Diagnosis

Status: Confirmed cause | Likely cause | Narrowed cause | Reproduced symptom | Unresolved

Summary:
One or two sentences explaining what appears to be happening.

Evidence Checked:
- source, command, log, trace, file, dashboard, report, screenshot, or runtime state: what it showed

Facts:
- directly supported observation with provenance

Hypotheses Considered:
- hypothesis: evidence for, evidence against, and result

Conclusion:
- cause or narrowed explanation
- confidence
- why this conclusion beats alternatives

Proof Gaps:
- unavailable, stale, inconclusive, destructive, credential-gated, or unchecked evidence

Most Useful Next Evidence:
- smallest additional evidence that would reduce uncertainty
```

If there is no confirmed or likely cause, lead with that. Do not turn the report into downstream action.

For short diagnoses, keep the sections but compress each to the minimum useful detail.
