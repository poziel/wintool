# Optimizer by hellzerg is an open-source tool designed to enhance Windows performance, privacy, and security.
# It allows users to disable unnecessary services, remove pre-installed bloatware, and optimize various
# system settings for a faster and more private Windows experience.

# Key Features:
# - Disables Windows services that aren’t essential to improve performance and free up system resources.
# - Provides privacy enhancements by disabling telemetry, background data collection, and tracking features
#   inherent in Windows.
# - Removes unwanted applications and pre-installed bloatware to streamline the system.
# - Offers a series of optimization tweaks for network, system, and Windows Explorer settings.
# - Includes additional tools like a Hosts file editor and support for bulk application installation and removal.

# Usage Example:
# - Running Optimizer after a fresh installation of Windows can help secure privacy, reduce background
#   resource usage, and improve overall system responsiveness.
# - Options can typically be selected from a user-friendly interface, making it accessible even for those
#   unfamiliar with advanced Windows settings.

# Typical Workflow:
# 1. Optimizer scans the system to detect active services, pre-installed apps, and telemetry features.
# 2. Users choose to disable or optimize specific items based on their needs (e.g., disabling telemetry,
#    stopping background services, or removing apps).
# 3. The tool applies the selected optimizations, which may require a system restart to fully take effect.

# Optimizer is especially useful for users who value privacy and performance, providing an all-in-one tool 
# to configure and streamline Windows without needing manual tweaks in multiple locations.

# Define the URL for the online DownloadRun script
$downloadRunUrl = "https://raw.githubusercontent.com/poziel/wintool/refs/heads/main/DownloadRun.ps1"

# Download and execute the script from the URL
Invoke-Expression -Command (Invoke-WebRequest -Uri $downloadRunUrl).Content

# Call the function with specific parameters for this app
DownloadRun -url "https://github.com/hellzerg/optimizer" -name "Optimizer"
