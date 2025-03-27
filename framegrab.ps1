# Copyright (c) 2025 Chris Calo
# Licensed under the MIT License.
#
# Framegrab Tool for Windows
# Usage: .\framegrab.ps1 <video_path> <timestamp>
# Example: .\framegrab.ps1 my_video.mp4 01:23.456

# Function to check if a command exists
function Test-CommandExists {
  param ($command)
  
  try {
    if (Get-Command $command -ErrorAction SilentlyContinue) {
      return $true
    }
  }
  catch {
    return $false
  }
  
  return $false
}

# Check if ffmpeg is installed
if (-not (Test-CommandExists ffmpeg)) {
  Write-Host "FFMPEG is not installed."
  
  # Check if Chocolatey is installed
  if (Test-CommandExists choco) {
    # Ask user if they want to install FFMPEG via Chocolatey
    $choice = Read-Host "Would you like to install FFMPEG using Chocolatey? (Y/n)"
    if ($choice -ne "n" -and $choice -ne "N") {
      Write-Host "Installing FFMPEG via Chocolatey (may require admin rights)..."
      
      try {
        # Try to install FFmpeg via Chocolatey
        Start-Process -FilePath "choco" -ArgumentList "install ffmpeg -y" -Verb RunAs -Wait
        
        # Refresh environment variables to find ffmpeg
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        # Check if the installation was successful
        if (Test-CommandExists ffmpeg) {
          Write-Host "FFMPEG installed successfully."
        }
        else {
          Write-Host "Could not verify FFMPEG installation. You may need to restart your terminal or computer."
          Write-Host "Alternatively, download FFMPEG manually from: https://ffmpeg.org/download.html"
          exit 1
        }
      }
      catch {
        Write-Host "Failed to install FFMPEG through Chocolatey."
        Write-Host "Please download FFMPEG manually from: https://ffmpeg.org/download.html"
        exit 1
      }
    }
    else {
      Write-Host "FFMPEG is required for this script. Please download it manually from: https://ffmpeg.org/download.html"
      exit 1
    }
  }
  else {
    Write-Host "Chocolatey package manager is not installed."
    Write-Host "Would you like to install it to easily get FFMPEG? (Y/n)"
    $choice = Read-Host
    
    if ($choice -ne "n" -and $choice -ne "N") {
      Write-Host "Please visit https://chocolatey.org/install for Chocolatey installation instructions."
    }
    
    Write-Host "For FFMPEG, please download it manually from: https://ffmpeg.org/download.html"
    exit 1
  }
}

# Check if we have the correct number of arguments
if ($args.Count -ne 2) {
  Write-Host "Usage: $PSCommandPath <video_path> <timestamp>"
  Write-Host "Timestamp format: MM:SS.mmm (minutes:seconds.milliseconds)"
  exit 1
}

$VideoPath = $args[0]
$Timestamp = $args[1]

# Validate video path exists
if (-not (Test-Path $VideoPath)) {
  Write-Host "Error: Video file does not exist: $VideoPath"
  exit 1
}

# Validate timestamp format (simple check)
if (-not ($Timestamp -match "^[0-9]+:[0-9]+(\.[0-9]+)?$")) {
  Write-Host "Error: Invalid timestamp format. Use MM:SS.mmm"
  exit 1
}

# Extract the base name without extension
$Basename = [System.IO.Path]::GetFileNameWithoutExtension($VideoPath)
$Directory = [System.IO.Path]::GetDirectoryName($VideoPath)
if ([string]::IsNullOrEmpty($Directory)) {
  $Directory = "."
}

# Format timestamp for filename (replace colons and periods with hyphens)
$TimestampFilename = $Timestamp -replace "[:,.]", "-"

# Output filename
$OutputFile = Join-Path -Path $Directory -ChildPath "$Basename-$TimestampFilename.png"

Write-Host "Extracting frame at $Timestamp from $VideoPath..."
ffmpeg -ss $Timestamp -i $VideoPath -frames:v 1 -q:v 1 $OutputFile

if ($LASTEXITCODE -eq 0) {
  Write-Host "Screenshot saved to: $OutputFile"
}
else {
  Write-Host "Failed to extract frame. Please check the video file and timestamp."
  exit 1
}
