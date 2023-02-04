#!/bin/sh
set -eu
echo ::group::Downloading FFmpeg $version for $RUNNER_OS
mkdir FFmpeg
if [ $RUNNER_OS = macOS ]
then
  if [ $version = master ]; then filename=get; else filename=ffmpeg-$version.7z; fi
  aria2c -x 16 -o FFmpeg.7z -q https://evermeet.cx/ffmpeg/$filename
  7z e FFmpeg.7z ffmpeg -oFFmpeg
  rm FFmpeg.7z
else
  if [ $version = master ]; then filename=ffmpeg-master-latest-linux64-gpl.tar.xz; else filename=ffmpeg-n$version-latest-linux64-gpl-$version.tar.xz; fi
  aria2c -x 16 -o FFmpeg.tar.xz -q $GITHUB_SERVER_URL/BtbN/FFmpeg-Builds/releases/download/latest/$filename
  tar -xf FFmpeg.tar.xz -C FFmpeg --strip-components 2 --no-anchored ffmpeg ffprobe
  rm FFmpeg.tar.xz
fi
echo ::endgroup::