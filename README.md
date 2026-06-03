# Mistle Skills

Open-source agent skills with a Bash installer for Mistle sandboxes

## Install

This repository ships a Bash installer for sandboxes where `git` and `bash` are available.

Add the following into Mistle's sandbox profile setup script if you want to install skills:

```bash
export HOME="${HOME:-/root}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"

git clone https://github.com/mistlehq/skills.git /tmp/mistle-skills
/tmp/mistle-skills/install.sh github-pr-authoring github-pr-review-subagents
```

Install one skill:

```bash
/tmp/mistle-skills/install.sh github-pr-authoring
```

Install multiple skills by passing each skill name as an argument:

```bash
/tmp/mistle-skills/install.sh github-pr-authoring github-pr-review-subagents
```

Install every skill in this repository:

```bash
/tmp/mistle-skills/install.sh
```

The installer detects the single installed agent runtime and installs config-level skills to the matching directory:

- Codex: `$CODEX_HOME/skills`, defaulting to `$HOME/.codex/skills`
- OpenCode: `$XDG_CONFIG_HOME/opencode/skills`, defaulting to `$HOME/.config/opencode/skills`

If `HOME` is not exported by the calling runtime, the installer resolves a stable
fallback before installing skills.

If no skill names are provided, the installer installs every first-level skill under `skills/`.

## Skills

- `codex-review`: Run Codex code review as a closeout check for local changes or PR branches.
- `file-issues`: File handoff-ready issues in an issue tracker from issue material, context, and references.
- `grill-with-docs`: Stress-test plans against project language and update CONTEXT.md/ADRs as decisions crystallize.
- `github-pr-authoring`: Draft or update GitHub PRs using Mistle's PR body format.
- `github-pr-review-subagents`: Review live GitHub pull requests with focused subagent review and main-reviewer validation.
- `improve-harness-engineering`: Audit and prioritize codebase harness improvements for coding-agent workflows.
- `install-playwright`: Reference pinned Playwright CLI installation and write repeatable setup scripts for sandbox or agent environments.
- `post-implementation-cleanup-loop`: Run repeated behavior-preserving cleanup review and fix rounds until no accepted findings remain.
- `write-a-skill`: Create or rewrite agent skills with clearer triggers, progressive disclosure, and compression.

## Attributions

- `codex-review`: [`openclaw/agent-skills`](https://github.com/openclaw/agent-skills/tree/main/skills/autoreview)
- `grill-with-docs`: [`mattpocock/skills`](https://github.com/mattpocock/skills/tree/main/skills/engineering/grill-with-docs)
- `improve-harness-engineering`: vocabulary adapted from Birgitta Bockeler's ["Harness engineering for coding agent users"](https://martinfowler.com/articles/harness-engineering.html)
- `write-a-skill`: adapted from [`mattpocock/skills`](https://github.com/mattpocock/skills/tree/main/skills/productivity/write-a-skill)
