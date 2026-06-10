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
    latest_release_linux=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[0].latest)
    if [ "$(curl -sLIo /dev/null -w %{http_code} $GITHUB_SERVER_URL/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-n$latest_release_linux-latest-linux64-gpl-$latest_release_linux.tar.xz)" = 404 ]
    then
      latest_release_linux=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[1].latest)
    fi
    latest_release=$latest_release_linux
  fi
  echo "version=$latest_release" >> $GITHUB_OUTPUT
else
  echo "version=$version" >> $GITHUB_OUTPUT
fi