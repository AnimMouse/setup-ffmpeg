$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
if ($env:version -eq 'stable') {
  $latest_stable = (Invoke-RestMethod https://endoflife.date/api/ffmpeg.json)[0].cycle
  Add-Content $env:GITHUB_OUTPUT version=$latest_stable
}
else {
  Add-Content $env:GITHUB_OUTPUT version=$env:version
}