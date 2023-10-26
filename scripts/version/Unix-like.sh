#!/bin/sh
set -eu
if [ "$version" = release ]
then
  if [ $RUNNER_OS = macOS ]
  then
    latest_release=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[0].latest)
  else
    latest_release=$(curl -s https://endoflife.date/api/ffmpeg.json | jq -r .[0].cycle)
  fi
  echo "version=$latest_release" >> $GITHUB_OUTPUT
else
  echo "version=$version" >> $GITHUB_OUTPUT
fi