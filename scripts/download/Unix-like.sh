#!/bin/sh
set -eu
echo ::group::Downloading FFmpeg $version for $RUNNER_OS $RUNNER_ARCH
mkdir FFmpeg
if [ $RUNNER_OS = macOS ]
then
  if [ $RUNNER_ARCH = ARM64 ]
  then
    ext=zip
    if [ $version = master ]
    then
      echo ::error::OSXExperts.NET currently does not have macOS ARM64 master builds.
      exit 1
    else
      wget -qO FFmpeg.zip https://www.osxexperts.net/ffmpeg${version}arm.zip
      wget -qO FFprobe.zip https://www.osxexperts.net/ffprobe${version}arm.zip
    fi
  else
    ext=7z
    if [ $version = master ]
    then
      wget -qO FFmpeg.7z https://evermeet.cx/ffmpeg/get
      wget -qO FFprobe.7z https://evermeet.cx/ffmpeg/get/ffprobe
    else
      wget -qO FFmpeg.7z https://evermeet.cx/ffmpeg/ffmpeg-$version.7z
      wget -qO FFprobe.7z https://evermeet.cx/ffprobe/ffprobe-$version.7z
    fi
  fi
  7z e FFmpeg.$ext ffmpeg -oFFmpeg
  7z e FFprobe.$ext ffprobe -oFFmpeg
  rm FFmpeg.$ext FFprobe.$ext
else
  if [ $RUNNER_ARCH = ARM64 ]; then arch=linuxarm64; else arch=linux64; fi
  if [ $version = master ]; then filename=ffmpeg-master-latest-$arch-gpl.tar.xz; else filename=ffmpeg-n$version-latest-$arch-gpl-$version.tar.xz; fi
  wget -qO- $GITHUB_SERVER_URL/BtbN/FFmpeg-Builds/releases/download/latest/$filename | tar -xJC FFmpeg --strip-components 2 --no-anchored ffmpeg ffprobe
fi
echo ::endgroup::