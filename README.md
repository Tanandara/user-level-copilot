# User-level GitHub Copilot configuration

Personal GitHub Copilot configuration shared across local projects. This repository is the source of truth; the installer copies its files to the user-level Copilot directory.

## Included configuration

```text
.
├─ copilot-instructions.md
├─ instructions/
│  ├─ python.instructions.md
│  ├─ dotnet.instructions.md
│  └─ terraform.instructions.md
├─ agents/
│  ├─ planner.agent.md
│  └─ reviewer.agent.md
└─ install-copilot-instructions.ps1
```

| Path | Purpose |
| --- | --- |
| `copilot-instructions.md` | Personal engineering principles used across projects. |
| `instructions/` | Path-specific guidance for Python, .NET, and Terraform files. |
| `agents/planner.agent.md` | Manual, read-only planning mode for scoped single- or multi-repository work. |
| `agents/reviewer.agent.md` | Manual, read-only change-review mode. |
| `skills/` | Intentionally not included yet. Add skills only for repeatable workflows that need detailed steps, scripts, templates, or reference material. |

## Install

Run PowerShell from this repository:

```powershell
.\install-copilot-instructions.ps1
```

The script installs the configuration to:

```text
~\.copilot\copilot-instructions.md
~\.copilot\instructions\
~\.copilot\agents\
```

If one or more target files already exist, the script stops without changing anything. Review the existing files, then use `-Force` to replace them:

```powershell
.\install-copilot-instructions.ps1 -Force
```

With `-Force`, the script creates a timestamped backup next to every target file before replacing it.

## Update workflow

1. Edit files in this repository.
2. Review the changes.
3. Run the installer with `-Force` when updating an existing local configuration.
4. In Copilot CLI, run `/instructions` to confirm that the expected instruction files are discovered.

## Multi-project planning

For changes across multiple repositories, start Copilot from a common parent folder when possible and explicitly name the repositories in scope.

```text
Use the Planner agent to plan changes across:
- D:\Projects\projects\project-a
- D:\Projects\projects\project-b

Do not modify files. Inspect both repositories and propose an implementation order.
```

The Planner agent is read-only and should return scope, assumptions, ordered changes per project, validation, compatibility, deployment, and rollback considerations.

## Public repository safety

This repository is intended to be public. Do not add credentials, tokens, private URLs, account IDs, production configuration, customer data, or repository-specific secrets. Keep project-specific architecture, commands, and deployment procedures in each project's own `AGENTS.md` or `.github` configuration.
