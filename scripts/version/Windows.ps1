$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
if ($env:version -eq 'release') {
  $latest_release = (Invoke-RestMethod https://endoflife.date/api/ffmpeg.json)[0].cycle
  Add-Content $env:GITHUB_OUTPUT version=$latest_release
}
else {
  Add-Content $env:GITHUB_OUTPUT version=$env:version
}