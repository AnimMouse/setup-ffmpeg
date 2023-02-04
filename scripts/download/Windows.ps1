$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
Write-Host ::group::Downloading FFmpeg $env:version for Windows
if ($env:version -eq 'master') {$filename = 'ffmpeg-master-latest-win64-gpl.zip'} else {$filename = "ffmpeg-n$env:version-latest-win64-gpl-$env:version.zip"}
aria2c -x 16 -o FFmpeg.zip -q $env:GITHUB_SERVER_URL/BtbN/FFmpeg-Builds/releases/download/latest/$filename
7z e FFmpeg.zip ffmpeg.exe ffprobe.exe -oFFmpeg -r
Remove-Item FFmpeg.zip
Write-Host ::endgroup::