[CmdletBinding()]
param(
    [switch]$Force
)

$sourcePath = Join-Path $PSScriptRoot 'copilot-instructions.md'
$sourceAgentsDirectory = Join-Path $PSScriptRoot 'agents'
$sourceInstructionsDirectory = Join-Path $PSScriptRoot 'instructions'
$userProfilePath = [Environment]::GetFolderPath('UserProfile')
$destinationDirectory = Join-Path $userProfilePath '.copilot'
$destinationPath = Join-Path $destinationDirectory 'copilot-instructions.md'
$destinationAgentsDirectory = Join-Path $destinationDirectory 'agents'
$destinationInstructionsDirectory = Join-Path $destinationDirectory 'instructions'

if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
    throw "Source file not found: $sourcePath"
}

$installItems = @(
    [pscustomobject]@{
        Source = $sourcePath
        Destination = $destinationPath
    }
)

if (Test-Path -LiteralPath $sourceInstructionsDirectory -PathType Container) {
    Get-ChildItem -LiteralPath $sourceInstructionsDirectory -File -Recurse | ForEach-Object {
        $relativePath = $_.FullName.Substring($sourceInstructionsDirectory.Length).TrimStart('\\')
        $installItems += [pscustomobject]@{
            Source = $_.FullName
            Destination = Join-Path $destinationInstructionsDirectory $relativePath
        }
    }
}

if (Test-Path -LiteralPath $sourceAgentsDirectory -PathType Container) {
    Get-ChildItem -LiteralPath $sourceAgentsDirectory -File -Recurse | ForEach-Object {
        $relativePath = $_.FullName.Substring($sourceAgentsDirectory.Length).TrimStart('\\')
        $installItems += [pscustomobject]@{
            Source = $_.FullName
            Destination = Join-Path $destinationAgentsDirectory $relativePath
        }
    }
}

$existingTargets = @($installItems | Where-Object { Test-Path -LiteralPath $_.Destination -PathType Leaf })
if ($existingTargets.Count -gt 0 -and -not $Force) {
    $targetList = ($existingTargets.Destination | ForEach-Object { " - $_" }) -join "`n"
    throw "The following target files already exist:`n$targetList`nNo changes were made. Review them, then rerun with -Force to back them up and replace them."
}

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'

foreach ($item in $installItems) {
    $itemDirectory = Split-Path -Parent $item.Destination
    New-Item -ItemType Directory -Path $itemDirectory -Force | Out-Null

    if (Test-Path -LiteralPath $item.Destination -PathType Leaf) {
        $backupPath = "$($item.Destination).backup-$timestamp"
        Copy-Item -LiteralPath $item.Destination -Destination $backupPath -ErrorAction Stop
        Write-Host "Backed up existing file to: $backupPath"
    }

    Copy-Item -LiteralPath $item.Source -Destination $item.Destination -Force -ErrorAction Stop
    Write-Host "Installed: $($item.Destination)"
}
