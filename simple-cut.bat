@echo off
setlocal enabledelayedexpansion

rem Get input file path
set input="%~1"

rem Get start and end times
set start_time=%2
set end_time=%3

rem Construct base output file path
set base_output="%~dpn1_cut.mp4"

rem Initialize counter for handling existing output files
set counter=1

:CheckExistence
rem Check if the output file already exists; if so, increment counter
if exist !base_output! (
    set base_output="%~dpn1_cut-!counter!.mp4"
    set /A counter+=1
    goto CheckExistence
)

rem Trim the video using FFmpeg with the avoid_negative_ts make_zero option
ffmpeg -i !input! -ss !start_time! -avoid_negative_ts make_zero -to !end_time! -c copy !base_output!
