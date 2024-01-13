@echo off
setlocal enabledelayedexpansion

set input=%1
set start_time=%2
set end_time=%3
set base_output=!input:.mp4=_cut!
set output=!base_output!.mp4
set counter=1

:CheckExistence
if exist !output! (
    set output=!base_output!-!counter!.mp4
    set /A counter+=1
    goto CheckExistence
)

ffmpeg -i !input! -ss !start_time! -to !end_time! -c copy !output!

discordcompressor.exe --size 25 !output!