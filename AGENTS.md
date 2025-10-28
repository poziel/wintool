# Agent Guidelines for WinTool

## Overview
WinTool is a PowerShell-based collection of one-shot Windows utility scripts that download, execute, and clean up portable tools.

## Build/Test Commands
- No build system - scripts are executed directly via PowerShell
- Test individual script: `pwsh -ExecutionPolicy Bypass -File apps/<scriptname>.ps1`
- Test remote execution: `irm https://wintool.poziel.dev/<scriptname> | iex`

## Domain Configuration
- Production domain: `https://wintool.poziel.dev/<scriptname>` (without `.ps1` extension)
- Domain redirects via nginx to: `https://raw.githubusercontent.com/poziel/wintool/refs/heads/master/apps/<scriptname>.ps1`
- Helper scripts accessible at: `https://wintool.poziel.dev/downloadrun` and `https://wintool.poziel.dev/urlsearch`

## Code Style

**File Structure**: Each app script follows a standard template:
- Multi-line comment block describing the tool, its features, usage examples, and workflow
- Remote execution instructions as comments using `https://wintool.poziel.dev/<scriptname>` format
- Shortcut creation command as a single-line comment using the same domain
- Parameter hashtable (`$params`) with tool-specific configuration
- Final line: Remote invocation of `downloadrun` script via `https://wintool.poziel.dev/downloadrun`

**Naming**: Use lowercase filenames (e.g., `cpuz.ps1`, `cleanmgr.ps1`). Organize vendor-specific tools in subdirectories (e.g., `apps/microsoft/`).

**Parameters**: Define parameters as hashtables using splatting pattern. Common parameters: `Url`, `GithubMatch`, `ArchiveApp`, `AppArgs`, `AppAdmin`, `NoCleanup`.

**Error Handling**: Use try-catch blocks in core scripts. Validate required parameters and provide clear error messages.

**Comments**: Include comprehensive header comments explaining tool purpose, features, usage, and workflow. No inline comments unless necessary for complex logic.
