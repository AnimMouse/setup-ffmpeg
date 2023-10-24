#!/bin/sh
set -eu
echo ::group::Downloading FFmpeg $version for $RUNNER_OS
mkdir FFmpeg
if [ $RUNNER_OS = macOS ]
then
  if [ $version = master ]; then filename=get; else filename=ffmpeg-$version.7z; fi
  wget -qO FFmpeg.7z https://evermeet.cx/ffmpeg/$filename
  7z e FFmpeg.7z ffmpeg -oFFmpeg
  rm FFmpeg.7z
else
  if [ $version = master ]; then filename=ffmpeg-master-latest-linux64-gpl.tar.xz; else filename=ffmpeg-n$version-latest-linux64-gpl-$version.tar.xz; fi
  wget -qO- $GITHUB_SERVER_URL/BtbN/FFmpeg-Builds/releases/download/latest/$filename | tar -xJC FFmpeg --strip-components 2 --no-anchored ffmpeg ffprobe
fi
echo ::endgroup::