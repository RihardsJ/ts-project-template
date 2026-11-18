# TypeScript Project Template

## Purpose and scope

This template sets up a TypeScript Nx workspace for web applications.
The workspace includes a local TypeScript, Vite, and Three.js reference application as a working example.
Deployment, service architecture, and shared runtime libraries remain deferred.

## Project map

- `README.md`: setup, checks, and architecture decisions.
- `CLAUDE.md`: Claude Code entry point importing this guidance.
- `.claude/settings.json`: official Nx Claude plugin and sandbox configuration.
- `apps/reference/`: the first browser application.
- `apps/reference/tests/`: lifecycle unit tests and Playwright browser checks.
- `apps/`: deployable application workspaces.
- `libs/`: future reusable runtime workspaces.
- `tools/`: future Node.js tooling workspaces.
- `nx.json`: task coordination, shared inputs, and local caching.
- `tsconfig.base.json`: shared strict compiler settings.
- `eslint.config.mjs`: typed linting and dependency constraints.

## Commands

Use Node.js from `.nvmrc` and npm with `package-lock.json`.

```sh
./setup.sh
npm ci
npm run browsers:install
npm run dev
npm run check
npm run check -- --skipNxCache
npm run lint
npm run typecheck
npm test
npm run build
npm run e2e
npm run nx -- show projects
```

`npm run check` is the project's check command. It runs lint, type checks, unit tests, builds, and browser tests, and it must pass before any work counts as done.
This file is the single place where the project's commands are recorded. Automation installed on top of this project, such as a software factory, reads its commands from here and must not assume them.
When a command changes, update this section in the same change.
`./setup.sh` prepares a fresh copy in one step: it installs dependencies and the test browser, then runs the check command.
No local services are currently required.
When worker sockets are unavailable, prefix Nx commands with `NX_ISOLATE_PLUGINS=false`.

## Nx workflow

For scaffolding requests, invoke the Nx plugin's `nx-generate` skill before exploring or creating files.
Use Nx generators first when creating applications, libraries, projects, or supported workspace configuration.
Prefer an existing workspace generator when it meets the requirement.
Discover plugin capabilities with `npm run nx -- list <plugin>`.
Read the generator's help, schema, and implementation before selecting options.
Preview supported generators with `--dry-run --no-interactive` before generating files.
If dry-run is unsupported, inspect and record the expected changes before execution.
Execute generators with `--no-interactive` to prevent unattended prompts.
After generation, adapt the output to this workspace's TypeScript settings, npm scripts, tests, and dependency tags.
If no suitable generator exists, record the limitation before making minimal manual changes.

Use `npm run nx -- <command>` to run the installed workspace CLI.
For workspace questions, invoke the plugin's `nx-workspace` skill and inspect the project graph.
Inspect available targets with `npm run nx -- show project <project> --json`.
Run builds, tests, linting, and type checks through Nx targets or the existing root wrappers.
Prefer `npm run nx -- run <project>:<target>` for a single project.
Use `npm run nx -- run-many -t <targets>` when several projects require verification.
Keep full checks as the delivery gate until affected-only execution has separate verification.

For plugin initialisation, use `nx add` with a version compatible with the installed Nx release.
Do not rerun `nx init` in this existing Nx workspace.
For Nx upgrades, use `nx migrate` and review the generated migrations before executing them.
When flags or APIs are unclear, consult Nx documentation or CLI help instead of guessing.
If plugin skills or MCP tools are unavailable, follow this workflow through the Nx CLI and report the limitation.
Keep project-specific rules outside the managed Nx block in `CLAUDE.md` so updates preserve them.

## Working rules

Preserve unrelated work.
Use npm workspace packages under `apps/*`, `libs/*`, or `tools/*`.
Give each project one type tag and one runtime tag.
Applications consume libraries. Libraries must not consume applications or tooling.
Keep browser code separate from Node.js tooling through dependency tags.
Declare task inputs and outputs before relying on cached results.
Keep full CI checks until affected-only execution has separate verification.
Build a reference application before extracting libraries or creating custom generators.
Before delivery, run `npm run check` and review the complete diff.
The quality command includes browser tests and requires Chromium installation through `npm run browsers:install`.
For CI on Linux, install Chromium and its system dependencies with `npm exec playwright install --with-deps chromium`.
Report executed checks and remaining limitations accurately.
Do not publish, merge, or deploy without explicit authorisation.
