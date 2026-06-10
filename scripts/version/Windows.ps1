$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
if ($env:version -eq 'release') {
  $latest_release = gh api repos/BtbN/FFmpeg-Builds/releases/latest -q `
    '[.assets[].name | capture("^ffmpeg-n(?<v>[0-9]+(?:\\.[0-9]+)+)-latest-") | .v] | unique | max_by(split(".") | map(tonumber))'
  Add-Content $env:GITHUB_OUTPUT version=$latest_release
}
else {
  Add-Content $env:GITHUB_OUTPUT version=$env:version
}