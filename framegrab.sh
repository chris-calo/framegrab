#!/bin/bash

# Copyright (c) 2025 Chris Calo
# Licensed under the MIT License.
#
# Framegrab Tool for macOS
# Usage: ./framegrab.sh <video_path> <timestamp>
# Example: ./framegrab.sh my_video.mp4 01:23.456

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if ffmpeg is installed
if ! command_exists ffmpeg; then
  echo "FFMPEG is not installed."
  
  # Check if Homebrew is installed
  if ! command_exists brew; then
    echo "Homebrew is not installed. Please install it first:"
    echo "Visit https://brew.sh for installation instructions."
    exit 1
  fi
  
  # Ask user if they want to install FFMPEG
  read -p "Would you like to install FFMPEG using Homebrew? (Y/n): " choice
  case "$choice" in
    n|N ) 
      echo "FFMPEG is required for this script. Exiting."
      exit 1
      ;;
    * ) 
      echo "Installing FFMPEG..."
      brew install ffmpeg
      
      # Check if installation was successful
      if ! command_exists ffmpeg; then
        echo "Failed to install FFMPEG. Please install it manually."
        exit 1
      fi
      echo "FFMPEG installed successfully."
      ;;
  esac
fi

# Check if we have the correct number of arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <video_path> <timestamp>"
  echo "Timestamp format: MM:SS.mmm (minutes:seconds.milliseconds)"
  exit 1
fi

VIDEO_PATH="$1"
TIMESTAMP="$2"

# Validate video path exists
if [ ! -f "$VIDEO_PATH" ]; then
  echo "Error: Video file does not exist: $VIDEO_PATH"
  exit 1
fi

# Validate timestamp format (simple check)
if ! [[ $TIMESTAMP =~ ^[0-9]+:[0-9]+(\.[0-9]+)?$ ]]; then
  echo "Error: Invalid timestamp format. Use MM:SS.mmm"
  exit 1
fi

# Extract the base name without extension
BASENAME=$(basename "$VIDEO_PATH")
BASENAME="${BASENAME%.*}"
DIRECTORY=$(dirname "$VIDEO_PATH")

# Format timestamp for filename (replace colons and periods with hyphens)
TIMESTAMP_FILENAME=$(echo "$TIMESTAMP" | tr ':.' '-')

# Output filename
OUTPUT_FILE="$DIRECTORY/$BASENAME-$TIMESTAMP_FILENAME.png"

echo "Extracting frame at $TIMESTAMP from $VIDEO_PATH..."
ffmpeg -ss "$TIMESTAMP" -i "$VIDEO_PATH" -frames:v 1 -q:v 1 "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
  echo "Screenshot saved to: $OUTPUT_FILE"
else
  echo "Failed to extract frame. Please check the video file and timestamp."
  exit 1
fi
