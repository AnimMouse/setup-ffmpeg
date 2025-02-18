#!/bin/sh
set -eu
if [ $RUNNER_OS = macOS ]
then
  if [ $RUNNER_ARCH = ARM64 ]
  then
    release_id=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[0].latest)
  else
    if [ $version = master ]
    then
      release_id=$(curl -s https://evermeet.cx/ffmpeg/info/ffmpeg/snapshot | jq -r .size)
    else
      release_id=$(curl -s https://evermeet.cx/ffmpeg/info/ffmpeg/$version | jq -r .size)
    fi
  fi
else
  release_id=$(gh api repos/BtbN/FFmpeg-Builds/releases/latest -q .id)
fi
echo release_id=$release_id >> $GITHUB_OUTPUT