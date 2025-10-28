# WinTool – One-Shot Windows Utilities ⚡

**WinTool** is a curated set of **PowerShell scripts** that download trusted Windows utilities on demand, run them, and remove all temporary files afterward.  
Perfect for quick diagnostics, optimization, security tasks, and system management — **no permanent installs, no clutter**.

---

## 🎯 Quick Start

### Option 1: Visit the Website
Browse all tools with descriptions at:
**[https://wintool.poziel.dev](https://wintool.poziel.dev)**

Click "Copy Command" or "One-Click" to get started instantly!

### Option 2: Interactive Menu
Launch the arrow-based menu in PowerShell:

```powershell
irm https://wintool.poziel.dev/get | iex
```

This will:
- Load the complete tool catalog from `tools.json`
- Display tools organized by category
- Let you navigate with arrow keys and launch with Enter
- No need to remember individual command names!

---

## 🛠 Available Tool Categories

WinTool includes utilities across multiple categories:

- **Hardware & Diagnostics** – CPU-Z, HWiNFO, CrystalDiskInfo, CrystalDiskMark
- **Privacy & Optimization** – O&O ShutUp10++, Optimizer, Cleanmgr+, xd-AntiSpy, SuperMSConfig
- **Microsoft Sysinternals** – Autoruns, Process Explorer, Process Monitor
- **System Utilities** – Microsoft Activation Scripts, BlockRazer, Everything, O&O RegEditor
- **Package Managers** – UniGetUI

**Total: 19 tools and growing!**

View the complete catalog:
- **Website:** [https://wintool.poziel.dev](https://wintool.poziel.dev)
- **Interactive Menu:** `irm https://wintool.poziel.dev/get | iex`

---



## ⚙ How to Use

### Direct Execution
If you know which tool you want, run it directly:

```powershell
irm https://wintool.poziel.dev/<scriptname> | iex
```

Replace `<scriptname>` with the tool name (e.g., `cpuz`, `hwinfo`, `optimizer`).

**Example:**
```powershell
irm https://wintool.poziel.dev/cpuz | iex
```

### How It Works
By default, each script will:
- **Download** the latest portable version of the tool
- **Run** it immediately (some tools may prompt for elevation)
- **Delete** all temporary files when you close the tool  
  *(Pass `-NoCleanup` when running the script to skip auto-cleanup)*

### Tool Catalog
All tool information is centrally managed in `tools.json`, making it easy to:
- Browse tools on the website
- Use the interactive PowerShell menu
- See descriptions, features, and categories in one place

---

## 🔒 Requirements

- Windows 10/11  
- PowerShell 5.1+ or PowerShell Core  
- Internet connection  
- Execution policy allowing script execution (for one-shot commands, run from a trusted shell)

---

## 📌 Roadmap

- [x] Interactive menu to select tools  
- [ ] Add checksum verification for downloaded files  
- [ ] Optional silent/auto mode for supported utilities  
- [ ] Script signing for enterprise environments
- [ ] Favorites/recently used tools tracking

---

## 📜 License

MIT License — see LICENSE file in the repository for details.
