function downloadrun {
    <#
    .SYNOPSIS
    Downloads an executable from a specified URL or GitHub repository and runs it, with optional cleanup.

    .DESCRIPTION
    The `downloadrun` function downloads an `.exe` file from either a direct URL or the latest release of a GitHub repository.
    It then executes the `.exe` file and, after execution completes, optionally cleans up the downloaded files.

    .EXAMPLE
    downloadrun -url "https://github.com/username/repository" -name "MyApp" -tmp "C:\CustomTemp" -match "specificfile.exe"
    Downloads `specificfile.exe` from the latest release of the specified GitHub repo, stores it in "C:\CustomTemp\MyApp", and executes it.

    .EXAMPLE
    & ([scriptblock]::Create((Invoke-WebRequest -Uri "https://raw.githubusercontent.com/poziel/wintool/refs/heads/main/scripts/downloadrun.ps1").Content)) @params
    Calls the `downloadrun` script remotely with parameters stored in the `@params` hashtable.
    #>

    param (
        [string]$url,                   # The URL of the `.exe` file or the GitHub repository in the format "owner/repo"
        [string]$name = $null,          # Optional. Specifies the name for the executable. Defaults to the downloaded file name if omitted
        [string]$tmp = "$env:TEMP",     # Optional. Specifies a temporary folder to store the downloaded executable. Defaults to the system temporary folder
        [string]$match = "*.exe",       # Optional. Specifies a pattern to match the executable name in the GitHub release if there are multiple `.exe` assets
        [string]$args = "",             # Optional. A string of arguments to pass to the executable upon execution
        [bool]$cleanup = $true          # Optional. If true, deletes the program folder after execution
        [bool]$wait = $false            # Optional. If true, waits for user input before exiting
    )

    # Validate URL
    if (-not $url) {
        Write-Output "Error: The 'url' parameter is required."
        return
    }

    # Check if the temp folder exists; create it if necessary
    if (!(Test-Path -Path $tmp)) {
        New-Item -ItemType Directory -Path $tmp -Force
    }

    # Set error handling
    $ErrorActionPreference = "Stop"
    try {
        # Check if the URL points to a GitHub repository or a direct URL
        if ($url -match "^https://github\.com/([^/]+)/([^/]+)") {
            $repoOwner = $matches[1]
            $repoName = $matches[2]
            $apiUrl = "https://api.github.com/repos/$repoOwner/$repoName/releases/latest"
            
            Write-Output "Fetching latest release information from GitHub for $repoOwner/$repoName..."
            # Retrieve latest release information from GitHub
            $response = Invoke-RestMethod -Uri $apiUrl -Headers @{ "User-Agent" = "PowerShell" }

            # Filter assets based on the 'match' pattern
            $asset = $response.assets | Where-Object { $_.name -like $match }
            if ($null -eq $asset) {
                Write-Output "No executable matching '$match' found in the latest release for $repoOwner/$repoName. Exiting."
                return
            }

            $downloadUrl = $asset.browser_download_url
            Write-Output "Matched .exe URL: $downloadUrl"

            # Use the executable name from the asset if 'name' was not provided
            if (-not $name) {
                $name = [System.IO.Path]::GetFileNameWithoutExtension($asset.name)
            }

        } else {
            # Assume it's a direct URL to an executable
            $downloadUrl = $url
            Write-Output "Using provided URL: $downloadUrl"

            # Use the executable name from the URL if 'name' was not provided
            if (-not $name) {
                $name = [System.IO.Path]::GetFileNameWithoutExtension($downloadUrl)
            }
        }

        # Define the folder and path for the executable
        $programFolder = Join-Path -Path $tmp -ChildPath $name
        $exePath = Join-Path -Path $programFolder -ChildPath "$name.exe"

        # Create the download folder if it does not exist
        if (!(Test-Path -Path $programFolder)) {
            New-Item -ItemType Directory -Path $programFolder -Force
        }

        # Download the .exe file to the specified folder with progress bar
        Write-Output "Downloading file from $downloadUrl to $exePath..."
        $webRequest = Invoke-WebRequest -Uri $downloadUrl -OutFile $exePath -UseBasicParsing -PassThru
        Write-Progress -Activity "Downloading" -Status "Downloading file..." -PercentComplete (($webRequest.RawContentLength / $webRequest.Headers["Content-Length"]) * 100)

        # Run the downloaded .exe file with optional arguments
        Write-Output "Executing the downloaded file with arguments: $args"
        Start-Process -FilePath $exePath -ArgumentList $args -Wait

        # Optional cleanup step
        if ($cleanup) {
            Write-Output "Cleaning up..."
            Remove-Item -Path $programFolder -Recurse -Force
        }

    } catch {
        Write-Output "An error occurred: $_"
        if (Test-Path -Path $programFolder) {
            Remove-Item -Path $programFolder -Recurse -Force
        }
        Write-Output "Cleanup completed. Exiting."
        return
    }
    finally {
        $ErrorActionPreference = "Continue"
    }

    # Wait at the end if requested
    if ($wait) {
        Write-Output "Press Enter to exit..."
        Read-Host
        return
    }
}
