# simple-cut
.bat file to cut a video on windows (Not tested on Linux)

Simple bat file to cut a video from desired times on Windows using ffmpeg. 

Dependencies: [ffmpeg](https://ffmpeg.org/) [Discordcompressor](https://github.com/vladaad/discordcompressor)

Usage: "simple-cut.bat [filename] [start-time] [end-time] [--mute]"

Example: ".\simple-cut.bat video.mp4 1:44 1:48 --mute"

Optionally you can also mute clips with the --mute option

I recommend adding the script to your path, for example D:/simple-cut/simple-cut.bat so you can use it anywhere in powershell (or cmd), the output video file gets placed in the input files folder regardless what direction your powershell is. 
