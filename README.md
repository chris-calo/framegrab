# Framegrab

A simple tool that takes a video and a timestamp, and creates a screenshot image at exactly that moment.

## Table of Contents

- [What This Tool Does](#what-this-tool-does)
- [How to Get the Tool](#how-to-get-the-tool)
- [How to Use](#how-to-use)
  - [On macOS 15+](#on-macos-15)
  - [On Windows 11+](#on-windows-11)
  - [On Linux (Ubuntu/PopOS/Debian 22.04+)](#on-linux-popos-2204)
- [Examples](#examples)
  - [macOS Example](#macos-example)
  - [Windows Example](#windows-example)
- [Troubleshooting FAQ](#troubleshooting-faq)

## What This Tool Does

Imagine you're watching a video and want to save a picture from a specific moment. This tool helps you do that! You tell it:
1. Which video you want to use
2. The exact time in the video (like "2 minutes and 30 seconds")

And it will create a picture file for you in the same folder as your video.

## How to Get the Tool

### Download from GitHub

1. Visit the GitHub page: `https://github.com/chris-calo/framegrab`
2. Look for the green "Code" button and click it
3. Select "Download ZIP"
4. Once downloaded, unzip the file to a folder on your computer

OR

If you're comfortable with the command line, you can run:
```
git clone https://github.com/chris-calo/framegrab.git
```

## How to Use

<details>
<summary><b>On macOS 15+</b></summary>

1. Open Terminal (find it in Applications > Utilities)
2. Navigate to where you saved the scripts:
   ```
   cd path/to/framegrab
   ```
3. Make the script executable (you only need to do this once):
   ```
   chmod +x framegrab.sh
   ```
4. Run the tool with your video and timestamp:
   ```
   ./framegrab.sh path/to/your/video.mp4 01:23.456
   ```
   
   The timestamp format is: minutes:seconds.milliseconds
</details>

<details>
<summary><b>On Linux (Ubuntu/PopOS/Debian 22.04+)</b></summary>

1. First, make sure FFMPEG is installed (required):
   ```
   sudo apt install ffmpeg
   ```

2. Open Terminal
3. Navigate to where you saved the scripts:
   ```
   cd path/to/framegrab
   ```
4. Make the script executable (you only need to do this once):
   ```
   chmod +x framegrab.sh
   ```
5. Run the tool with your video and timestamp:
   ```
   ./framegrab.sh path/to/your/video.mp4 01:23.456
   ```
   
   The timestamp format is: minutes:seconds.milliseconds
</details>

<details>
<summary><b>On Windows 11+</b></summary>

1. Open PowerShell (right-click on the Start button and select "Windows PowerShell")
2. Navigate to where you saved the scripts:
   ```
   cd path\to\framegrab
   ```
3. Run the tool with your video and timestamp:
   ```
   .\framegrab.ps1 path\to\your\video.mp4 01:23.456
   ```
   
   The timestamp format is: minutes:seconds.milliseconds
</details>

## Examples

### macOS Example

Let's say you have a video called "birthday_party.mp4" in your Downloads folder, and you want a screenshot at 2 minutes and 15.5 seconds:

```
./framegrab.sh ~/Downloads/birthday_party.mp4 02:15.5
```

This will create a file called "birthday_party-02-15-5.png" in your Downloads folder.

### Windows Example

Let's say you have a video called "holiday_video.mp4" on your desktop, and you want a screenshot at 3 minutes and 45 seconds:

```
.\framegrab.ps1 C:\Users\YourName\Desktop\holiday_video.mp4 03:45.000
```

This will create a file called "holiday_video-03-45-000.png" on your desktop.

### Linux Example

Let's say you have a video called "lecture.mp4" in your Videos folder, and you want a screenshot at 5 minutes and 12 seconds:

```
./framegrab.sh ~/Videos/lecture.mp4 05:12.000
```

This will create a file called "lecture-05-12-000.png" in your Videos folder.

## Troubleshooting FAQ

<details>
<summary><b>What's FFMPEG and why do I need it?</b></summary>

FFMPEG is a free tool that helps work with videos. Our script uses it to extract images from your videos. Don't worry, the script will help you install it if you don't have it.
</details>

<details>
<summary><b>"Command not found" error on macOS</b></summary>

If you see an error like "command not found," try these steps:

1. Make sure you're in the right folder where the script is saved
2. Check that you've made the script executable with: `chmod +x framegrab.sh`
</details>

<details>
<summary><b>"Execution of scripts is disabled" error on Windows</b></summary>

If Windows doesn't let you run the script, you might need to change the execution policy:

1. Open PowerShell as Administrator (right-click, "Run as Administrator")
2. Run this command:
   ```
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
3. Try running the script again
</details>

<details>
<summary><b>What is Homebrew (for macOS users)?</b></summary>

Homebrew is like an app store for your Mac's Terminal. It helps install useful tools like FFMPEG. 

**Important**: Homebrew requires Xcode (or Xcode Command Line Tools) to be installed. If you don't have it:

1. Install Xcode Command Line Tools by opening Terminal and running:
   ```
   xcode-select --install
   ```
2. Follow the on-screen instructions to complete the installation

Then, to install Homebrew:

1. Open Terminal
2. Paste and run this command:
   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
3. Follow the instructions on screen
</details>

<details>
<summary><b>FFMPEG installation issues on Linux</b></summary>

If you have trouble installing FFMPEG on your Linux system:

1. Make sure your package lists are up-to-date:
   ```
   sudo apt update
   ```

2. Then try installing FFMPEG again:
   ```
   sudo apt install ffmpeg
   ```

If you're still having issues, it might be due to repository configuration. On Ubuntu/PopOS or other Debian-based systems, FFMPEG should be available in the standard repositories.
</details>

<details>
<summary><b>What is Chocolatey (for Windows users)?</b></summary>

Chocolatey is like an app store for your Windows command line. It helps install useful tools like FFMPEG. If our script suggests installing it, you can:

1. Open PowerShell as Administrator (right-click, "Run as Administrator")
2. Paste and run this command:
   ```
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```
3. Once installed, restart PowerShell before using our tool
</details>

<details>
<summary><b>The video exists but I get "file does not exist" error</b></summary>

Make sure you're using the correct path to your video. For example:

- On macOS: Use `~/Documents/myvideo.mp4` for files in your Documents folder
- On Windows: Use full paths like `C:\Users\YourName\Videos\myvideo.mp4`
- On Linux: Use `~/Videos/myvideo.mp4` for files in your Videos folder

If your path has spaces, put it in quotes:
- macOS: `./framegrab.sh "~/My Videos/birthday party.mp4" 01:23.456`
- Windows: `.\framegrab.ps1 "C:\Users\YourName\My Videos\birthday party.mp4" 01:23.456`
- Linux: `./framegrab.sh "~/My Videos/birthday party.mp4" 01:23.456`
</details>

<details>
<summary><b>The screenshot is black or incorrect</b></summary>

This could happen if:
1. The timestamp is beyond the length of the video
2. The video format is unusual or corrupted

Try a different timestamp or check if the video plays correctly in a media player.
</details>

<details>
<summary><b>How do I find the exact timestamp I want?</b></summary>

1. Play your video in VLC media player or similar
2. Pause at the exact frame you want
3. Note the time displayed (usually at the bottom of the player)
4. Use that time as your timestamp
</details>

<details>
<summary><b>My screenshot is low quality</b></summary>

The tool creates screenshots at the same quality as your video. If your video is low resolution, the screenshot will be too.
</details>

<details>
<summary><b>Need More Help?</b></summary>

If you're still having trouble, please create an issue on our GitHub page with:
1. The exact command you ran
2. The error message you received
3. Your operating system version

We'll help you sort it out!
</details>

---

## License

Copyright © 2025 Chris Calo

This project is licensed under the MIT License - see the LICENSE file for details.
