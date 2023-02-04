#!/bin/sh
set -eu
if [ $version = stable ]
then
  if [ $RUNNER_OS = macOS ]
  then
    latest_stable=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[0].latest)
  else
    latest_stable=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[0].cycle)
  fi
  echo version=$latest_stable >> $GITHUB_OUTPUT
else
  echo version=$version >> $GITHUB_OUTPUT
fi