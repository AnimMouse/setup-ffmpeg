# Setup FFmpeg for GitHub Actions
Setup [FFmpeg](https://ffmpeg.org) on GitHub Actions to use `ffmpeg` and `ffprobe`.

This action installs [FFmpeg](https://ffmpeg.org) for use in actions by installing it on tool cache using [AnimMouse/tool-cache](https://github.com/AnimMouse/tool-cache).

Ubuntu and Windows builds are provided by [BtbN/FFmpeg-Builds](https://github.com/BtbN/FFmpeg-Builds).\
macOS builds are provided by [evermeet.cx](https://evermeet.cx/ffmpeg/).\
macOS arm64 builds are provided by [OSXExperts.NET](https://osxexperts.net).

This action is implemented as a [composite](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) action.

## Usage
### FFmpeg
To use `ffmpeg`, run this action before `ffmpeg`.

```yaml
steps:
  - name: Setup FFmpeg
    uses: AnimMouse/setup-ffmpeg@v1
    
  - run: ffmpeg -i in.mkv out.mkv
```

### FFprobe
To use `ffprobe`, run this action before `ffprobe`.

```yaml
steps:
  - name: Setup FFmpeg
    uses: AnimMouse/setup-ffmpeg@v1
    
  - run: ffprobe in.mkv
```

### Specific version
You can specify the version you want. By default, this action downloads the latest release version if version is not specified.

#### Latest master
```yaml
steps:
  - name: Setup FFmpeg
    uses: AnimMouse/setup-ffmpeg@v1
    with:
      version: master
```

There are no master builds on macOS arm64.

#### Specific release
For Ubuntu and Windows, specify the major and minor version only. Visit [BtbN/FFmpeg-Builds](https://github.com/BtbN/FFmpeg-Builds/releases/tag/latest) for the list of release tags.

```yaml
steps:
  - name: Setup FFmpeg
    uses: AnimMouse/setup-ffmpeg@v1
    with:
      version: 7.1
```

For macOS, specify the major, minor, and patch version. Visit [evermeet.cx](https://evermeet.cx/pub/ffmpeg/) for the list of release tags.

```yaml
steps:
  - name: Setup FFmpeg
    uses: AnimMouse/setup-ffmpeg@v1
    with:
      version: 7.0.2
```

For macOS arm64, specify the major, minor version only without the point. Visit [OSXExperts.NET](https://osxexperts.net) for the list of release tags.

```yaml
steps:
  - name: Setup FFmpeg
    uses: AnimMouse/setup-ffmpeg@v1
    with:
      version: 71
```

### GitHub token
This action automatically uses a GitHub token in order to authenticate with the GitHub API and avoid rate limiting. You can also specify your own read-only fine-grained personal access token.

```yaml
steps:
  - name: Setup FFmpeg
    uses: AnimMouse/setup-ffmpeg@v1
    with:
      token: ${{ secrets.GH_PAT }}
```

#### Similar actions
1. [FedericoCarboni/setup-ffmpeg](https://github.com/FedericoCarboni/setup-ffmpeg)