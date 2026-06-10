$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
if ($env:version -eq 'release') {
  $latest_release = (Invoke-RestMethod https://endoflife.date/api/ffmpeg.json)[0].cycle
  Invoke-RestMethod -Uri $env:GITHUB_SERVER_URL/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-n$latest_release-latest-win64-gpl-$latest_release.zip -Method Head -StatusCodeVariable 'status_code' -SkipHttpErrorCheck
  if ($status_code -eq '404') {
    $latest_release = (Invoke-RestMethod https://endoflife.date/api/ffmpeg.json)[1].cycle
  }
  Add-Content $env:GITHUB_OUTPUT version=$latest_release
}
else {
  Add-Content $env:GITHUB_OUTPUT version=$env:version
}