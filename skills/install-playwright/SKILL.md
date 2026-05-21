---
name: install-playwright
description: Reference how to install pinned Playwright CLI, browser binaries, and Playwright CLI skills, especially when writing repeatable setup scripts. Use when the user asks to plan Playwright CLI installation, prepare a sandbox or agent environment, create install scripts, or perform a one-time setup.
---

# Playwright CLI Install Reference

Use this skill as an installation reference for `playwright-cli`. Prefer using it to design a repeatable setup script; use it for one-time installation only when the user explicitly wants the current machine prepared.

## Pinned Package

Use the pinned package version:

```sh
npm install -g @playwright/cli@0.1.13
```

Do not install `@playwright/cli@latest`. Keep the version pinned unless the user explicitly asks to update it, then verify the new version from npm before changing this skill.

## Choose The Mode

Default to writing or reviewing a repeatable install script when the user is preparing a sandbox, profile, container, bootstrap flow, or agent environment.

Run the commands directly only when the user asks for one-time installation on the current machine.

In either mode, the install plan should cover:

- `@playwright/cli@0.1.13`
- Chromium browser binaries
- Playwright CLI skills

## Script Requirements

For sandbox setup scripts, generate a script that:

1. exits on failure with `set -euo pipefail`
2. verifies `node` and `npm` are available
3. verifies Node.js is 20 or newer
4. installs `@playwright/cli@0.1.13`
5. installs Chromium with `playwright-cli install-browser chromium`
6. adds `--with-deps` to the browser install on Linux
7. installs Playwright CLI skills with `playwright-cli install --skills`
8. verifies `playwright-cli --help`

Let the agent write the script to match the target environment instead of copying a fixed template.

## One-Time Install

Run:

```sh
node -v
npm -v
npm install -g @playwright/cli@0.1.13
playwright-cli install-browser chromium
playwright-cli install --skills
command -v playwright-cli
playwright-cli --help
```

Use `playwright-cli install-browser chromium --with-deps` on Linux.

## Package Managers

Prefer npm global install because it matches the official Playwright CLI install path and works well for sandbox setup.

If the target repo or sandbox has an existing package-manager policy, use the equivalent pinned package install:

```sh
npm install --save-dev @playwright/cli@0.1.13
pnpm add -D @playwright/cli@0.1.13
yarn add -D @playwright/cli@0.1.13
```

Then run `playwright-cli` through that package manager, such as `npx playwright-cli --help` or `pnpm exec playwright-cli --help`.

## Notes

- Browser binaries are version-coupled to Playwright CLI. If the pinned package version changes, rerun the browser install command.
- If `node -v` reports a version below 20, stop and ask the user how they want Node installed or upgraded for that environment.
- If global npm installation is not acceptable in the target environment, use the user's preferred package-manager policy instead of improvising.
