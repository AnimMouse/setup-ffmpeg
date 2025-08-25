#!/bin/sh
set -eu
if [ "$version" = release ]
then
  if [ $RUNNER_OS = macOS ]
  then
    if [ $RUNNER_ARCH = ARM64 ]
    then
      latest_release_macos=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[0].cycle)
      latest_release_macos_arm64=$(basename $latest_release_macos .0)
      latest_release=${latest_release_macos_arm64/.}
    else
      latest_release_macos=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[0].latest)
      if [ "$(curl -s https://evermeet.cx/ffmpeg/info/ffmpeg/$latest_release_macos | jq .code)" = 404 ]
      then
        latest_release_macos=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[1].latest)
      fi
      latest_release=$(basename $latest_release_macos .0)
    fi
  else
    latest_release_linux=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[0].cycle)
    if [ "$(curl -sLI $GITHUB_SERVER_URL/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-n$latest_release_linux-latest-linux64-gpl-$latest_release_linux.tar.xz | head -n 1 | cut -d$' ' -f2)" = 404 ]
    then
      latest_release_linux=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[1].cycle)
    fi
    latest_release=$latest_release_linux
  fi
  echo "version=$latest_release" >> $GITHUB_OUTPUT
else
  echo "version=$version" >> $GITHUB_OUTPUT
fi