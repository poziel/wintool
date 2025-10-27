# WinTool – One-Shot Windows Utilities ⚡

**WinTool** is a curated set of **PowerShell scripts** that download trusted Windows utilities on demand, run them, and remove all temporary files afterward.  
Perfect for quick diagnostics, optimization, security tasks, and system management — **no permanent installs, no clutter**.

---

## 🛠 Current Available Scripts & Purpose

Below is the list of scripts currently available in the repository, each matching an existing `.ps1` file. All follow the one-shot execution model:

- **`cleanmgr`** – Launches *Cleanmgr+* for extended disk cleanup options beyond Windows’ built-in tool.  
- **`cpuz`** – Runs *CPU-Z* for detailed CPU, memory, and motherboard specifications.  
- **`diskinfo`** – Opens *CrystalDiskInfo* to check drive health and S.M.A.R.T. status.  
- **`diskmark`** – Runs *CrystalDiskMark* for storage performance benchmarking.  
- **`envyupdate`** – Updates NVIDIA drivers easily via *EnvyUpdate*.  
- **`hwinfo`** – Opens *HWiNFO* for full hardware and sensor monitoring.  
- **`mas`** – Executes *Microsoft Activation Scripts* from Massgrave for licensing tasks.  
- **`ooapb`** – Runs *O&O AppBuster* to remove or restore Windows preinstalled apps.  
- **`ooregedt`** – Launches *O&O RegEditor* for an enhanced registry editing experience.  
- **`oosu10`** – Runs *O&O ShutUp10++* for Windows privacy and telemetry control.  
- **`optimizer`** – Opens *Optimizer* for system tweaks, startup management, and privacy settings.  
- **`supermsconfig`** – Runs *Super MSConfig* to manage startup programs and services.  
- **`unigetui`** – Opens *UniGetUI* for managing software installations via package managers.  
- **`winutils`** – Launches *Windows Utilities* for quick access to hidden system tools.  
- **`xdantispy`** – Runs *XDAntiSpy* to adjust Windows privacy and telemetry settings.  
- **`blockrazer`** – Blocks Razer software auto-installation prompts when plugging in devices.  
- **`autoruns`** – Opens Microsoft Sysinternals’ *Autoruns* for advanced startup entry management.  
- **`procexp`** – Runs Microsoft Sysinternals’ *Process Explorer* for detailed process management.  
- **`procmon`** – Runs Microsoft Sysinternals’ *Process Monitor* for real-time system activity tracing.

---

## ⚙ How to Use (Global Instructions)

You can execute any WinTool script directly from the repository without downloading the entire repo, using the following PowerShell command:

```powershell
irm https://raw.githubusercontent.com/poziel/wintool/refs/heads/master/apps/<scriptname>.ps1 | iex
```

Replace `<scriptname>` with one of the available scripts listed above.  
Example for running CPU-Z:

```powershell
irm https://raw.githubusercontent.com/poziel/wintool/refs/heads/master/apps/cpuz.ps1 | iex
```

By default:
- The script will **download** the latest portable version of the tool
- It will **run** it immediately (some tools may prompt for elevation)
- Once closed, it will **delete all temporary files**  
  *(Pass `-NoCleanup` when running the script to skip auto-cleanup)*

---

## 🔒 Requirements

- Windows 10/11  
- PowerShell 5.1+ or PowerShell Core  
- Internet connection  
- Execution policy allowing script execution (for one-shot commands, run from a trusted shell)

---

## 📌 Roadmap

- [ ] Add checksum verification for downloaded files  
- [ ] Interactive menu to select tools  
- [ ] Optional silent/auto mode for supported utilities  
- [ ] Script signing for enterprise environments

---

## 📜 License

MIT License — see LICENSE file in the repository for details.
