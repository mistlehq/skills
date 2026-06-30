# Mistle Skills

Open-source agent skills for Mistle sandbox profiles

## Use In Mistle

Use this repository as a Mistle sandbox profile Skills source.

1. Open a sandbox profile version in Mistle.
2. In the Skills section, choose this repository as the Skills source.
3. Load or reload skills from the source.
4. Select the skills that should be available to the agent runtime.
5. Publish the sandbox profile version.

Mistle discovers skills by scanning the repository for `SKILL.md` files. Each skill
directory should include YAML frontmatter with a unique `name` and a
`description`.

## Skills

- `autoreview`: Run structured code review with the bundled helper, using Codex by default and optional alternate engines.
- `cleanup-implementation`: Clean up a working implementation without changing intended behavior.
- `diagnose-issue`: Diagnose observable technical or operational issues from evidence and state confidence, proof, and gaps.
- `file-issues`: File handoff-ready issues in an issue tracker from issue material, context, and references.
- `grill-with-docs`: Stress-test plans against project language and update CONTEXT.md/ADRs as decisions crystallize.
- `implement-with-alignment`: Normalize an implementation brief, get explicit alignment, then execute, verify, and prepare the completed change for publication.
- `improve-harness-engineering`: Audit and prioritize codebase harness improvements for coding-agent workflows.
- `improve-system-architecture`: Review codebase architecture from a system vantage point and recommend repo-local, cross-repo, or system-level improvements.
- `review-pull-request`: Review live GitHub pull requests with focused subagent review and main-reviewer validation.
- `write-a-skill`: Create or rewrite agent skills with clearer triggers, progressive disclosure, and compression.
- `write-pull-request`: Write GitHub PR titles and descriptions using Mistle's PR body format.

## Attributions

- `autoreview`: [`openclaw/agent-skills`](https://github.com/openclaw/agent-skills/tree/main/skills/autoreview)
- `grill-with-docs`: [`mattpocock/skills`](https://github.com/mattpocock/skills/tree/main/skills/engineering/grill-with-docs)
- `improve-harness-engineering`: vocabulary adapted from Birgitta Bockeler's ["Harness engineering for coding agent users"](https://martinfowler.com/articles/harness-engineering.html)
- `improve-system-architecture`: adapted from [`mattpocock/skills`](https://github.com/mattpocock/skills/tree/main/skills/engineering/improve-codebase-architecture)
- `write-a-skill`: adapted from [`mattpocock/skills`](https://github.com/mattpocock/skills/tree/main/skills/productivity/write-a-skill)
