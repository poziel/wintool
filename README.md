# wintool

A set of PowerShell scripts to dynamically download, run, and then clean up utility tools from the web. This project automates the setup and usage of a collection of Windows utilities, allowing users to quickly access and execute them without manual downloads or installation steps.

## Purpose

**wintool** streamlines the process of running popular Windows utilities by:
- Downloading the latest version of each tool.
- Executing the tool immediately after download.
- Cleaning up by deleting the downloaded files once they’re no longer needed.

## How to Use

1. **Clone the Repository**: Clone this repository to your local machine.
   ```bash
   git clone https://github.com/poziel/wintool.git
   ```

2. **Navigate to the Script**: Open PowerShell and navigate to the folder containing the scripts.

3. **Run the Script**: Execute the desired script by running:
   ```powershell
   .\ScriptName.ps1
   ```
   Replace `ScriptName.ps1` with the name of the script you wish to run.

4. **Optional - Create Shortcuts**: Follow the instructions at the end of each script to create shortcuts for easy access in the future.

## Available Scripts

Each script is dedicated to a specific Windows utility. Current scripts include tools for system optimization, privacy management, diagnostics, and more. More details for each tool are available in the `scripts` folder.
