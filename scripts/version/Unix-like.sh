#!/bin/sh
set -eu
if [ "$version" = release ]
then
  if [ $RUNNER_OS = macOS ]
  then
    if [ $RUNNER_ARCH = ARM64 ]
    then
      latest_release=$(curl -s https://www.osxexperts.net | grep -o 'https://www.osxexperts.net/ffmpeg[0-9.]*arm.zip' | awk -F 'ffmpeg|arm.zip' '{print $2}')
    else
      latest_release=$(curl -s https://evermeet.cx/ffmpeg/info/ffmpeg/release | jq -r .version)
    fi
  else
    latest_release=$(gh api repos/BtbN/FFmpeg-Builds/releases/latest -q '[.assets[].name | capture("^ffmpeg-(?:n)?(?<v>[0-9]+(?:\\.[0-9]+)+)") | .v] | max_by(split(".") | map(tonumber))')
  fi
  echo "version=$latest_release" >> $GITHUB_OUTPUT
else
  echo "version=$version" >> $GITHUB_OUTPUT
fi