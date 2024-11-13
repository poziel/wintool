# O&O ShutUp10++ is a free Windows privacy tool designed to give users control over their data privacy 
# and security settings on Windows 10 and Windows 11. It provides a centralized interface for disabling 
# built-in telemetry, data collection, and other settings that may compromise user privacy.

# Key Features:
# - Allows disabling of telemetry, diagnostics, and location tracking features that collect user data.
# - Provides options to control app permissions, Windows updates, Cortana, OneDrive integration, and 
#   personalized advertising.
# - Helps configure privacy-related security settings, such as password reveal buttons and feedback prompts.
# - Offers pre-configured recommendations for settings based on privacy levels (e.g., Basic, Recommended, Full Privacy).
# - Allows users to create restore points, so changes can be easily undone if necessary.

# Usage Example:
# - Running O&O ShutUp10++ presents users with a list of privacy-related settings, each with a clear description 
#   and recommended status.
# - Users can apply all recommended settings in one go or selectively enable/disable individual options to match 
#   their desired privacy level.

# Typical Workflow:
# 1. O&O ShutUp10++ scans the system and provides a list of privacy and security settings, categorized by function.
# 2. Users review each setting and select which ones to apply, following the built-in recommendations if desired.
# 3. The tool applies the changes, enhancing system privacy, with the option to revert any setting later.

# O&O ShutUp10++ is an ideal tool for users who value privacy and want granular control over Windows data collection 
# and telemetry features, making it easier to protect personal data without needing to navigate complex system settings.

# Define parameters to pass as a hashtable (flexible to add/remove parameters)
$params = @{
    url = "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe"
}

# Download, create, and execute the script block with parameters
& ([scriptblock]::Create((Invoke-WebRequest -Uri "https://raw.githubusercontent.com/poziel/wintool/refs/heads/main/downloadrun.ps1").Content)) @params
