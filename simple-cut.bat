@echo off
setlocal enabledelayedexpansion

set input=%1
set start_time=%2
set end_time=%3
set output=!input:.mp4=_cut.mp4!

ffmpeg -i !input! -ss !start_time! -to !end_time! -c copy !output!
