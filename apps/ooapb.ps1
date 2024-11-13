# O&O AppBuster is a free Windows tool that helps users manage and remove unwanted pre-installed applications, 
# or "bloatware," from Windows 10 and Windows 11 systems. This includes system apps, bundled apps, 
# and other installed software that may not be easily uninstallable through regular settings.

# Key Features:
# - Lists all pre-installed apps on a Windows system, including hidden and protected system apps.
# - Allows selective removal of unwanted applications, including bundled software and unnecessary system apps.
# - Supports reinstallation of previously removed apps in case they are needed later.
# - Provides an overview of app usage, helping users decide which apps to keep or remove.
# - Offers "Undo" functionality, allowing users to restore removed apps.

# Usage Example:
# - Running O&O AppBuster allows users to go through a list of installed applications and 
#   select which to uninstall for a cleaner, leaner system.
# - Users can also remove specific system apps, which are not usually accessible via regular uninstallation.

# Typical Workflow:
# 1. O&O AppBuster scans the system for all installed applications and displays them in a categorized list.
# 2. The user reviews the applications and selects unwanted ones for removal.
# 3. O&O AppBuster uninstalls the selected apps and updates the list, with an option to restore if needed.

# O&O AppBuster is ideal for users looking to declutter their Windows experience by removing unnecessary 
# or unwanted apps, freeing up system resources, and enhancing system performance.

# Define parameters to pass as a hashtable (flexible to add/remove parameters)
$params = @{
    url = "https://dl5.oo-software.com/files/ooappbuster/OOAPB.exe"
}

# Download, create, and execute the script block with parameters
& ([scriptblock]::Create((Invoke-WebRequest -Uri "https://raw.githubusercontent.com/poziel/wintool/refs/heads/main/downloadrun.ps1").Content)) @params
