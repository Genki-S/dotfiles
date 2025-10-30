#!/bin/bash

# Voice to Terminal Script
# Runs whisper-mic and feeds result to terminal

set -euo pipefail

notify_error() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        notify-send "Voice Dictation Error" "❌ Script failed: $1" --urgency=critical
    fi
    exit $exit_code
}

trap 'notify_error "Unexpected error occurred"' ERR
trap 'notify_error "Script interrupted"' INT TERM

# Check dependencies
if ! command -v curl &> /dev/null; then
    notify-send "Voice Dictation Error" "❌ curl not found. Install with: sudo apt install curl" --urgency=critical
    exit 1
fi
if ! command -v jq &> /dev/null; then
    notify-send "Voice Dictation Error" "❌ jq not found. Install with: sudo apt install jq" --urgency=critical
    exit 1
fi
if ! command -v xdotool &> /dev/null; then
    notify-send "Voice Dictation Error" "❌ xdotool not found. Install with: sudo apt install xdotool" --urgency=critical
    exit 1
fi
if ! command -v notify-send &> /dev/null; then
    echo "❌ notify-send not found. Install libnotify-bin package."
    exit 1
fi

# Configuration
WHISPER_DAEMON_URL="http://localhost:6423"

notify-send "Voice Dictation" "🎤 Listening..." &

# Call whisper-daemon API
response=$(curl -s -X POST "$WHISPER_DAEMON_URL/transcribe-mic" 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$response" ]; then
    notify-send "Voice Dictation Error" "❌ Failed to connect to whisper-daemon" --urgency=critical
    exit 1
fi

# Extract transcription from JSON response using jq
transcribed_text=$(echo "$response" | jq -r '.transcription // empty')

# Clean up transcription
transcribed_text=$(echo "$transcribed_text" | sed 's/^\s\+//' | sed 's/\s\+$//')

if [[ -z "$transcribed_text" ]]; then
    notify-send "Voice Dictation Error" "❌ No speech detected or transcription failed" --urgency=critical
    exit 1
fi

# Type the result in the active window (terminal)
if ! xdotool type "$transcribed_text"; then
    notify-send "Voice Dictation Error" "❌ Failed to type text" --urgency=critical
    exit 1
fi

notify-send "Voice Dictation" "✅ Transcribed: $transcribed_text"
