function DownloadRun {
    param (
        [string]$url,                       # Either a direct URL to an .exe or a GitHub repo in format "owner/repo"
        [string]$name,                      # Name of the program (used for file names)
        [string]$temp = "$env:TEMP"         # Optional: Custom temporary folder (default is system temp folder)
    )

    # Define the full path for the temporary folder and .exe file
    $programFolder = Join-Path -Path $temp -ChildPath $name
    $exePath = Join-Path -Path $programFolder -ChildPath "$name.exe"

    # Determine if input is a GitHub repo or a direct URL
    if ($url -match "^https://github\.com/([^/]+)/([^/]+)") {
        $repoOwner = $matches[1]
        $repoName = $matches[2]
        $apiUrl = "https://api.github.com/repos/$repoOwner/$repoName/releases/latest"
        
        Write-Output "Fetching latest release information from GitHub for $repoOwner/$repoName..."
        $response = Invoke-RestMethod -Uri $apiUrl -Headers @{ "User-Agent" = "PowerShell" }

        $asset = $response.assets | Where-Object { $_.name -like "*.exe" }
        if ($null -eq $asset) {
            Write-Output "No .exe file found in the latest release for $repoOwner/$repoName. Exiting."
            return
        }

        $downloadUrl = $asset.browser_download_url
        Write-Output "Latest release .exe URL: $downloadUrl"

    } else {
        # Assume it's a direct URL
        $downloadUrl = $url
        Write-Output "Using provided URL: $downloadUrl"
    }

    # Create the program-specific folder if it does not exist
    if (!(Test-Path -Path $programFolder)) {
        New-Item -ItemType Directory -Path $programFolder -Force
    }

    # Download the .exe file
    Write-Output "Downloading file from $downloadUrl to $exePath..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $exePath

    # Run the .exe file
    Write-Output "Executing the downloaded file..."
    Start-Process -FilePath $exePath -Wait

    # Delete the folder after execution completes
    Write-Output "Cleaning up..."
    Remove-Item -Path $programFolder -Recurse -Force

    Write-Output "Process completed and folder deleted."
}

# Example usage for testing purposes (comment out in production)
# DownloadRun -url "https://github.com/username/repository" -name "MyProgram" -temp "C:\CustomTemp"
# DownloadRun -url "https://example.com/yourfile.exe" -name "AnotherProgram" -temp "D:\OtherTemp"
