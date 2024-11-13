# UniGetUI is an open-source graphical user interface (GUI) tool for Windows, designed to manage multiple 
# command-line package managers in a single, unified interface. It simplifies the process of installing, 
# updating, and uninstalling software across different package managers, including Winget, Chocolatey, Scoop, 
# Pip, Npm, and .NET Tool.

# Key Features:
# - Unified Package Management: Provides a single interface to interact with multiple package managers, 
#   making it easy to manage software from various sources.
# - Bulk Operations: Supports batch installation, updating, and removal of packages, saving time and effort.
# - Detailed Package Information: Displays metadata such as download URLs, publisher information, and file 
#   sizes for each package.
# - Customization: Offers options to customize installation parameters, including version selection and 
#   architecture choices.
# - Export and Import: Enables exporting lists of installed packages, facilitating setup on new machines or 
#   for backup purposes.
# - Auto-Updater: Keeps both UniGetUI and managed packages up to date automatically.

# Usage Example:
# - UniGetUI can be installed via Winget with the command:
#   winget install --id SomePythonThings.WingetUIStore --source winget
# - After installation, UniGetUI’s interface allows users to manage software from all supported package 
#   managers, combining package management tasks into a single, easy-to-navigate application.

# Recent Developments:
# - Originally called WingetUI, the project was renamed to UniGetUI in early 2024 to better reflect its 
#   expanded support for multiple package managers. The latest release includes improvements such as enhanced 
#   troubleshooting for Winget and optimized handling of package operations.

# UniGetUI is ideal for users who want centralized control over software management on Windows, providing 
# a comprehensive tool to streamline the use of multiple package managers.

# Define parameters to pass as a hashtable (flexible to add/remove parameters)
$params = @{
    url = "https://github.com/marticliment/UniGetUI"
    match = "UniGetUI.Installer.exe"
    args = '/PORTABLE /DIR="$env:TEMP\UniGetUI_Portable"'
}

# Download, create, and execute the script block with parameters
& ([scriptblock]::Create((Invoke-WebRequest -Uri "https://raw.githubusercontent.com/poziel/wintool/refs/heads/main/scripts/downloadrun.ps1").Content)) @params

