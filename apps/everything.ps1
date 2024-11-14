# Everything by Voidtools is a fast and efficient search utility for Windows, designed to help users quickly 
# locate files and folders on their system with minimal resource usage.

# Key Features:
# - Provides instant file indexing, allowing searches to return results as soon as you start typing.
# - Allows users to search by file name, folder, size, and date modified for precise results.
# - Uses minimal system resources, making it efficient for everyday use without impacting performance.
# - Supports advanced search operators for complex queries and filtering.
# - Includes options to create bookmarks for frequent searches and export search results.

# Usage Example:
# - Running Everything lets users start typing a search query to find files instantly:
#   Everything -Search "example.txt"
# - Here, '-Search' initiates a query for "example.txt" across indexed directories.

# Typical Workflow:
# 1. Everything indexes all files and folders on the system drive for fast searching.
# 2. Users enter a search query, and results are displayed in real-time as they type.
# 3. Advanced options allow users to filter or refine results based on specific criteria.

# Everything by Voidtools is ideal for users needing a powerful and resource-friendly search tool to manage 
# and locate files on Windows quickly and efficiently.

# To create a shortcut for Everything by Voidtools, execute the following line in PowerShell:
# $shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut((Join-Path -Path (Get-Location) -ChildPath "Voidtools - Everything.lnk")); $shortcut.TargetPath = "$env:windir\System32\WindowsPowerShell\v1.0\powershell.exe"; $shortcut.Arguments = "-ExecutionPolicy Bypass -Command `"Start-Process powershell.exe -verb runas -ArgumentList 'irm https://raw.githubusercontent.com/poziel/wintool/refs/heads/main/apps/everything.ps1 | iex'`""; $shortcut.WorkingDirectory = "$env:windir\System32\WindowsPowerShell\v1.0"; $shortcut.Description = "Everything by Voidtools is a fast search utility to quickly locate files and folders on Windows."; $shortcut.Save()

# Get the download URL from the urlsearch script first
$url = & ([scriptblock]::Create((Invoke-WebRequest -Uri "https://raw.githubusercontent.com/poziel/wintool/refs/heads/main/scripts/urlsearch.ps1").Content)) -url "https://www.voidtools.com/downloads/" -text "Download Portable Zip 64-bit"

# Define parameters to pass as a hashtable (flexible to add/remove parameters)
$params = @{
    url = $url
    name = "HWiNFO64\HWiNFO64.zip"
    app = "HWiNFO64.exe"
}

# Download, create, and execute the script block with parameters
& ([scriptblock]::Create((Invoke-WebRequest -Uri "https://raw.githubusercontent.com/poziel/wintool/refs/heads/main/scripts/downloadrun.ps1").Content)) @params