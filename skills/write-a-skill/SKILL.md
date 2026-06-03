---
name: write-a-skill
description: Create new agent skills or improve existing skills with clearer triggers, progressive disclosure, and compression. Use when the user wants to create, write, build, rewrite, shorten, consolidate, or improve a skill.
---

# Writing Skills

## Process

Choose the path:

- **New skill**: gather requirements, use `TEMPLATE.md` for the skeleton, add references or scripts only if needed.
- **Existing skill**: assess current behavior first, then rewrite for shorter and clearer execution without losing the behaviors that matter.

For new skills, ask what task/domain it covers, what use cases it handles, whether it needs scripts or only instructions, and what reference materials to include.

For existing skills, assess what behavior must be preserved, which instructions affect activation/execution/validation/output, which instructions are duplicated or vague, and what can move into the description, a reference file, or a script.

When improving an existing skill:

1. State the must-preserve behaviors before editing.
2. Move trigger-only guidance into the frontmatter `description`.
3. Rewrite body prose as direct conditions: `If X, do Y`.
4. Merge duplicate rules and delete rationale that does not change behavior.
5. Split rare or advanced details into one-level reference files.
6. Re-check the result against the must-preserve behaviors.

## Skill Critique Pass

Before finishing a skill change, run a critique pass:

- Does each new instruction change behavior rather than restating another rule?
- Is each concept owned in one place, with other files only routing to it?
- Is the skill standalone unless it is explicitly an orchestrator?
- Do output requirements improve style without forcing awkward visible labels?
- Does the skill distinguish ready actions from unresolved decisions?
- Does required behavior sound optional because of phrases like "when relevant" or "if material"?
- Are examples necessary, or could they bias future usage?

Do not only add instructions. After adding, subtract and centralize. A good skill change should usually make the skill more precise, not just longer.

## Skill Structure

```text
skill-name/
├── SKILL.md
├── TOPIC.md       # one-level reference files when detailed docs are needed
└── scripts/       # if deterministic helpers are needed
```

Use [TEMPLATE.md](TEMPLATE.md) for the minimal new-skill skeleton.

## Description Requirements

The description is **the only thing your agent sees** when deciding which skill to load.

Give just enough info to identify what capability the skill provides and when to trigger it: keywords, contexts, file types, or user intents.

Format:

- max 1024 chars
- third person
- first sentence: what it does
- second sentence: `Use when...`

## When to Add Scripts

Add utility scripts when:

- Operation is deterministic (validation, formatting)
- Same code would be generated repeatedly
- Errors need explicit handling

## When to Split Files

Split into separate files when:

- SKILL.md exceeds 100 lines
- Content has distinct domains (finance vs sales schemas)
- Advanced features are rarely needed

Keep references one level deep from `SKILL.md`.

## Review Checklist

After drafting or rewriting, verify:

- [ ] Description includes triggers (`Use when...`)
- [ ] SKILL.md under 100 lines
- [ ] Must-preserve behaviors are still covered
- [ ] Body instructions are direct, conditional, and non-duplicative
- [ ] Critique pass completed: necessity, ownership, coupling, output shape, decision sensitivity, conditionality, examples
- [ ] No time-sensitive info
- [ ] Consistent terminology
- [ ] Examples are included only when necessary and unlikely to bias usage
- [ ] References one level deep
