<#
.SYNOPSIS
WinTool - Interactive menu to discover and launch Windows utility scripts

.DESCRIPTION
This script fetches the tools.json catalog and presents an interactive arrow-based menu
for easy tool discovery and execution.

Use arrow keys (↑↓) to navigate, Enter to select, Q to quit, L to list commands.

.EXAMPLE
irm https://wintool.poziel.dev/get | iex
Launches the interactive WinTool menu with arrow-based navigation

.EXAMPLE
irm https://wintool.poziel.dev/get | iex -List
Lists all available tools with their commands

.NOTES
Tool information is centrally managed in tools.json
Arrow navigation provides a modern, intuitive interface
#>

param(
    [switch]$List,      # List all tools without interaction
    [switch]$Simple     # Simple text output instead of interactive menu
)

# Configuration
$ToolsJsonUrl = "https://raw.githubusercontent.com/poziel/wintool/refs/heads/master/tools.json"

# Function to fetch tools from JSON
function Get-AllTools {
    Write-Host "Loading tool catalog..." -ForegroundColor Cyan
    
    try {
        # Fetch tools.json
        $response = Invoke-RestMethod -Uri $ToolsJsonUrl -ErrorAction Stop
        
        Write-Host "Found $($response.tools.Count) tools!`n" -ForegroundColor Green
        
        # Convert to consistent format with category info
        $tools = $response.tools | ForEach-Object {
            $categoryInfo = $response.categories[$_.category]
            
            [PSCustomObject]@{
                Name = $_.name
                DisplayName = if ($_.vendor) { "$($_.displayName) by $($_.vendor)" } else { $_.displayName }
                ShortDisplayName = $_.displayName
                Vendor = $_.vendor
                Description = $_.description
                Features = $_.features
                CategoryKey = $_.category
                CategoryName = $categoryInfo.name
                CategoryIcon = $categoryInfo.icon
                CategoryDescription = $categoryInfo.description
                Url = $_.url
            }
        }
        
        return $tools | Sort-Object CategoryName, DisplayName
        
    } catch {
        Write-Error "Failed to fetch tool catalog: $_"
        Write-Host "`nNote: This script requires an internet connection to load the tool catalog." -ForegroundColor Yellow
        return @()
    }
}

# Function to display tools grouped by category
function Show-ToolList {
    param([array]$Tools)
    
    $groupedTools = $Tools | Group-Object -Property CategoryName | Sort-Object Name
    
    Write-Host "`n╔═══════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                    WinTool - Available Utilities                          ║" -ForegroundColor Cyan
    Write-Host "╚═══════════════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan
    
    foreach ($group in $groupedTools) {
        $categoryIcon = $group.Group[0].CategoryIcon
        Write-Host "`n  $categoryIcon $($group.Name)" -ForegroundColor Yellow
        
        # Show category description
        $categoryDesc = $group.Group[0].CategoryDescription
        if ($categoryDesc) {
            Write-Host "  $categoryDesc" -ForegroundColor DarkGray
        }
        Write-Host ""
        
        foreach ($tool in $group.Group) {
            Write-Host "    • " -NoNewline -ForegroundColor Green
            Write-Host "$($tool.DisplayName)" -ForegroundColor White
            Write-Host "      $($tool.Description)" -ForegroundColor Gray
            Write-Host "      Command: " -NoNewline -ForegroundColor DarkGray
            Write-Host "irm $($tool.Url) | iex" -ForegroundColor Cyan
        }
    }
    
    Write-Host "`n  To run any tool, copy and paste its command, or use: " -ForegroundColor Yellow
    Write-Host "  irm https://wintool.poziel.dev/get | iex" -ForegroundColor Cyan -NoNewline
    Write-Host " (for interactive menu)`n" -ForegroundColor Yellow
}

# Function to show interactive menu with arrow navigation
function Show-InteractiveMenu {
    param([array]$Tools)
    
    $groupedTools = $Tools | Group-Object -Property CategoryName | Sort-Object Name
    $menuItems = @()
    $selectedIndex = 0
    
    # Build flat menu items list with category headers
    foreach ($group in $groupedTools) {
        $categoryIcon = $group.Group[0].CategoryIcon
        
        # Add category header (not selectable)
        $menuItems += [PSCustomObject]@{
            Type = "Header"
            DisplayName = "$categoryIcon $($group.Name)"
            CategoryName = $group.Name
        }
        # Add tools
        foreach ($tool in $group.Group) {
            $menuItems += [PSCustomObject]@{
                Type = "Tool"
                DisplayName = $tool.DisplayName
                Description = $tool.Description
                Url = $tool.Url
                CategoryName = $group.Name
            }
        }
    }
    
    # Find first selectable item
    while ($menuItems[$selectedIndex].Type -eq "Header") {
        $selectedIndex++
    }
    
    # Main loop
    while ($true) {
        Clear-Host
        Write-Host "`n╔═══════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║                    WinTool - Interactive Menu                             ║" -ForegroundColor Cyan
        Write-Host "╚═══════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  Use ↑↓ arrows to navigate, Enter to select, Q to quit, L to list commands" -ForegroundColor DarkGray
        
        # Display menu
        for ($i = 0; $i -lt $menuItems.Count; $i++) {
            $item = $menuItems[$i]
            
            if ($item.Type -eq "Header") {
                Write-Host "`n  ▶ $($item.DisplayName)" -ForegroundColor Yellow
            } else {
                $isSelected = ($i -eq $selectedIndex)
                
                if ($isSelected) {
                    Write-Host "    → " -NoNewline -ForegroundColor Green
                    Write-Host "$($item.DisplayName)" -ForegroundColor Green
                    Write-Host "      $($item.Description)" -ForegroundColor DarkGreen
                } else {
                    Write-Host "      $($item.DisplayName)" -ForegroundColor White
                    Write-Host "      $($item.Description)" -ForegroundColor DarkGray
                }
            }
        }
        
        Write-Host ""
        
        # Get key input
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        
        switch ($key.VirtualKeyCode) {
            38 { # Up arrow
                do {
                    $selectedIndex--
                    if ($selectedIndex -lt 0) {
                        $selectedIndex = $menuItems.Count - 1
                    }
                } while ($menuItems[$selectedIndex].Type -eq "Header")
            }
            40 { # Down arrow
                do {
                    $selectedIndex++
                    if ($selectedIndex -ge $menuItems.Count) {
                        $selectedIndex = 0
                    }
                } while ($menuItems[$selectedIndex].Type -eq "Header")
            }
            13 { # Enter
                $selectedTool = $menuItems[$selectedIndex]
                Clear-Host
                Write-Host "`n  Launching: $($selectedTool.DisplayName)" -ForegroundColor Green
                Write-Host "  Command: irm $($selectedTool.Url) | iex`n" -ForegroundColor Cyan
                Write-Host "  Executing...`n" -ForegroundColor Yellow
                
                try {
                    & ([scriptblock]::Create((Invoke-WebRequest -Uri $selectedTool.Url -UseBasicParsing).Content))
                } catch {
                    Write-Host "`n  Error: $_`n" -ForegroundColor Red
                    Read-Host "  Press Enter to continue"
                }
                return
            }
            81 { # Q key
                Write-Host "`nExiting WinTool. Goodbye!`n" -ForegroundColor Yellow
                return
            }
            76 { # L key
                Show-ToolList -Tools $Tools
                Read-Host "`nPress Enter to return to menu"
                # Continue loop to redisplay menu
            }
        }
    }
}

# Main execution
$tools = Get-AllTools

if ($tools.Count -eq 0) {
    Write-Host "No tools found. Please check your internet connection and try again." -ForegroundColor Red
    exit 1
}

# Display based on parameters
if ($List -or $Simple) {
    Show-ToolList -Tools $tools
} else {
    Show-InteractiveMenu -Tools $tools
}
