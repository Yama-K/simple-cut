@echo off

rem Check if FFmpeg is installed
where ffmpeg >nul 2>&1
if errorlevel 1 (
    echo FFmpeg is not installed or not in the system PATH. Exiting.
    exit /b 1
)

rem Check if DiscordCompressor is installed
where discordcompressor.exe >nul 2>&1
if errorlevel 1 (
    echo DiscordCompressor is not installed or not in the system PATH. Exiting.
    exit /b 1
)

rem Check if enough arguments are provided
if "%~3"=="" (
    echo Usage: simple-cut.bat input_video start_time end_time [--mute]
    exit /b 1
)

rem Set input file path
set "input=%~1"

rem Parse start time and end time
for /f "tokens=1,2 delims=:" %%a in ("%~2") do set "start_minute=%%a" & set "start_second=%%b"
for /f "tokens=1,2 delims=:" %%a in ("%~3") do set "end_minute=%%a" & set "end_second=%%b"

rem Convert start time and end time to seconds
set /a "start_time=(start_minute*60)+start_second"
set /a "end_time=(end_minute*60)+end_second"

rem Calculate duration
set /a "duration=end_time-start_time"

rem Construct output file name
set "output=%~dpn1_cut.mp4"

rem Trim the video using FFmpeg
ffmpeg -ss %start_time% -i "%input%" -t %duration% -c:v copy "%output%"

echo Video trimmed successfully from %start_minute%:%start_second% to %end_minute%:%end_second%.

rem Compress the trimmed video using DiscordCompressor
discordcompressor.exe --size 25 "%output%"

rem If the --mute option is provided, remove the audio from the trimmed video
if "%~4"=="--mute" (
    ffmpeg -i "%output%" -c:v copy -an "%~dpn1_cut_muted.mp4"
    move /y "%~dpn1_cut_muted.mp4" "%output%"
    echo Audio removed from the trimmed video.
)
