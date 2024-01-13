#!/bin/bash

input="$1"
start_time="$2"
end_time="$3"
base_output="${input%.mp4}_cut"
output="$base_output.mp4"
counter=1

while [ -e "$output" ]; do
    output="${base_output}-$counter.mp4"
    ((counter++))
done

ffmpeg -i "$input" -ss "$start_time" -to "$end_time" -c copy "$output"
