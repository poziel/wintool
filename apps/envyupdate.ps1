# EnvyUpdate is a PowerShell-based tool for updating NVIDIA graphics drivers on Windows.
# The tool automates the process of downloading and installing the latest NVIDIA driver versions,
# helping users keep their GPU drivers up to date without manual intervention.

# Key Features:
# - Checks for the latest version of NVIDIA drivers directly from the NVIDIA website or API.
# - Downloads the driver package automatically and installs it silently (without user interaction).
# - Provides options for different driver types, such as Game Ready Driver (GRD) or Studio Driver (SD),
#   depending on user needs (e.g., gaming or content creation).
# - Offers a clean installation mode to remove previous driver remnants, helping improve stability.

# Usage Example:
# - Running EnvyUpdate in a PowerShell terminal might look like:
#   EnvyUpdate -DriverType GRD -CleanInstall
# - Here, '-DriverType GRD' specifies the Game Ready Driver, and '-CleanInstall' performs a fresh installation.

# Typical Workflow:
# 1. EnvyUpdate checks the system for the currently installed NVIDIA driver version.
# 2. It then queries the latest available driver version.
# 3. If a newer version is available, EnvyUpdate downloads the driver package.
# 4. After downloading, it installs the new driver silently, and optionally, performs a clean install.

# EnvyUpdate provides a convenient and streamlined way for users to manage NVIDIA driver updates,
# ideal for gamers and professionals who want to ensure optimal GPU performance with minimal manual effort.

# To create a shortcut for EnvyUpdate, execute the following line in PowerShell:
# $shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut((Join-Path -Path (Get-Location) -ChildPath "EnvyUpdate.lnk")); $shortcut.TargetPath = "$env:windir\System32\WindowsPowerShell\v1.0\powershell.exe"; $shortcut.Arguments = "-ExecutionPolicy Bypass -Command `"Start-Process powershell.exe -verb runas -ArgumentList 'irm https://raw.githubusercontent.com/poziel/wintool/refs/heads/main/apps/envyupdate.ps1 | iex'`""; $shortcut.WorkingDirectory = "$env:windir\System32\WindowsPowerShell\v1.0"; $shortcut.Description = "EnvyUpdate is a PowerShell tool that automates downloading and installing the latest NVIDIA graphics drivers."; $shortcut.Save()

# Define parameters to pass as a hashtable (flexible to add/remove parameters)
$params = @{
    url = "https://github.com/fyr77/EnvyUpdate"
}

# Download, create, and execute the script block with parameters
& ([scriptblock]::Create((Invoke-WebRequest -Uri "https://raw.githubusercontent.com/poziel/wintool/refs/heads/main/scripts/downloadrun.ps1").Content)) @params
