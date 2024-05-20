#!/bin/sh
set -eu
if [ "$version" = release ]
then
  if [ $RUNNER_OS = macOS ]
  then
    latest_release_macos=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[0].latest)
    if [ "$(curl -s https://evermeet.cx/ffmpeg/info/ffmpeg/$latest_release_macos | jq .code)" = 404 ]
    then
      latest_release_macos=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[1].latest)
    fi
    latest_release=$(basename $latest_release_macos .0)
  else
    latest_release=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[0].cycle)
  fi
  echo "version=$latest_release" >> $GITHUB_OUTPUT
else
  echo "version=$version" >> $GITHUB_OUTPUT
fi