#!/bin/bash

# Check if FFmpeg is installed
if ! command -v ffmpeg &> /dev/null
then
    echo "FFmpeg is not installed or not in the system PATH. Exiting."
    exit 1
fi

# Check if enough arguments are provided
if [ "$#" -lt 3 ]
then
    echo "Usage: $0 input_video start_time end_time [--mute]"
    exit 1
fi

# Set input file path
input="$1"

# Parse start time and end time
IFS=':' read -r start_minute start_second <<< "$2"
IFS=':' read -r end_minute end_second <<< "$3"

# Convert start time and end time to seconds
start_time=$((start_minute*60 + start_second))
end_time=$((end_minute*60 + end_second))

# Calculate duration
duration=$((end_time - start_time))

# Construct output file name
output="${input%.*}_cut.mp4"

# Trim the video using FFmpeg
ffmpeg -ss "$start_time" -i "$input" -t "$duration" -c:v copy "$output"

echo "Video trimmed successfully from $start_minute:$start_second to $end_minute:$end_second."

# If the --mute option is provided, remove the audio from the trimmed video
if [ "$4" = "--mute" ]; then
    ffmpeg -i "$output" -c:v copy -an "${output%.*}_muted.mp4"
    mv "${output%.*}_muted.mp4" "$output"
    echo "Audio removed from the trimmed video."
fi
