# Autoruns by Microsoft is a powerful utility that provides detailed insight into startup items, 
# allowing users to view, manage, and disable programs and services that automatically run on Windows startup.

# Key Features:
# - Displays comprehensive lists of startup items, including programs, services, drivers, and scheduled tasks.
# - Allows users to enable or disable startup entries with a single click, giving full control over what runs at startup.
# - Identifies locations of startup items across the registry and file system for in-depth management.
# - Highlights known malware entry points and offers trusted Microsoft items for easy identification.
# - Includes options to search for additional details on startup items online for informed decision-making.

# Usage Example:
# - Running Autoruns provides an interface to browse startup entries and control them:
#   Autoruns -Disable "ExampleStartupProgram"
# - Here, '-Disable' removes the specified program from startup, preventing it from loading with Windows.

# Typical Workflow:
# 1. Autoruns scans the system and lists all items set to run at startup across different categories.
# 2. The user reviews items and disables or enables them based on needs.
# 3. Autoruns provides options to hide Microsoft entries, making it easier to spot third-party or potentially unwanted items.

# Autoruns is an essential tool for users and administrators looking to optimize system performance, 
# troubleshoot startup issues, or enhance security by managing startup applications effectively.

# To create a shortcut for Autoruns by Microsoft, execute the following line in PowerShell:
# $shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut((Join-Path -Path (Get-Location) -ChildPath "Microsoft - Autoruns.lnk")); $shortcut.TargetPath = "$env:windir\System32\WindowsPowerShell\v1.0\powershell.exe"; $shortcut.Arguments = "-ExecutionPolicy Bypass -Command `"Start-Process powershell.exe -verb runas -ArgumentList 'irm https://raw.githubusercontent.com/poziel/wintool/refs/heads/main/apps/microsoft/autoruns.ps1 | iex'`""; $shortcut.WorkingDirectory = "$env:windir\System32\WindowsPowerShell\v1.0"; $shortcut.Description = "Autoruns by Microsoft is a utility for managing Windows startup items, offering control over programs and services that run automatically."; $shortcut.Save()

# Define parameters to pass as a hashtable (flexible to add/remove parameters)
$params = @{
    url = "https://download.sysinternals.com/files/Autoruns.zip"
    app = "Autoruns.exe"
}

# Download, create, and execute the script block with parameters
& ([scriptblock]::Create((Invoke-WebRequest -Uri "https://raw.githubusercontent.com/poziel/wintool/refs/heads/main/scripts/downloadrun.ps1").Content)) @params
