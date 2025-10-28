# Agent Guidelines for WinTool

## Overview
WinTool is a PowerShell-based collection of one-shot Windows utility scripts that download, execute, and clean up portable tools.

## Directory Structure
- `/scripts/` - Individual tool scripts (one per utility)
- `/commons/` - Shared helper scripts (downloadrun.ps1, urlsearch.ps1)
- `/get.ps1` - Interactive menu script that fetches and displays the tool catalog
- `/tools.json` - Central catalog of all tools with metadata (name, description, features, category, URL)
- `/index.html` - Web interface for browsing and copying tool commands

## Build/Test Commands
- No build system - scripts are executed directly via PowerShell
- Test individual script: `pwsh -ExecutionPolicy Bypass -File scripts/<scriptname>.ps1`
- Test remote execution: `irm https://wintool.poziel.dev/<scriptname> | iex`
- Launch interactive menu: `irm https://wintool.poziel.dev/get | iex`

## Domain Configuration
- Production domain: `https://wintool.poziel.dev/<scriptname>` (without `.ps1` extension)
- Domain redirects via nginx to: `https://raw.githubusercontent.com/poziel/wintool/master/scripts/<scriptname>.ps1`
- Helper scripts: `https://wintool.poziel.dev/commons/downloadrun.ps1` and `https://wintool.poziel.dev/commons/urlsearch.ps1`
- Interactive menu: `https://wintool.poziel.dev/get`
- Tool catalog (JSON): `https://raw.githubusercontent.com/poziel/wintool/master/tools.json`
- Web interface: `https://wintool.poziel.dev` (index.html)

## Tool Catalog Management

All tool information is centrally managed in `tools.json`. When adding a new tool:

1. Create the script in `/scripts/` following the standard template
2. Add the tool entry to `tools.json` with:
   - `name`: Script filename without .ps1 extension
   - `displayName`: User-friendly tool name
   - `vendor`: Tool creator/vendor (optional)
   - `category`: One of the predefined categories
   - `description`: Comprehensive tool description
   - `features`: Array of key features (3-5 bullet points)
   - `url`: Full wintool.poziel.dev URL

The catalog is used by:
- `get.ps1` - Interactive PowerShell menu
- `index.html` - Web interface
- Both stay automatically in sync with tools.json

## Code Style

**File Structure**: Each app script follows a standard template:
- Multi-line comment block describing the tool, its features, usage examples, and workflow
- Remote execution instructions as comments using `https://wintool.poziel.dev/<scriptname>` format
- Shortcut creation command as a single-line comment using the same domain
- Parameter hashtable (`$params`) with tool-specific configuration
- Final line: Remote invocation of `downloadrun` script via `https://wintool.poziel.dev/commons/downloadrun.ps1`

**Naming**: Use lowercase filenames (e.g., `cpuz.ps1`, `cleanmgr.ps1`). Organize vendor-specific tools in subdirectories (e.g., `apps/microsoft/`).

**Parameters**: Define parameters as hashtables using splatting pattern. Common parameters: `Url`, `GithubMatch`, `ArchiveApp`, `AppArgs`, `AppAdmin`, `NoCleanup`.

**Error Handling**: Use try-catch blocks in core scripts. Validate required parameters and provide clear error messages.

**Comments**: Include comprehensive header comments explaining tool purpose, features, usage, and workflow. No inline comments unless necessary for complex logic.
