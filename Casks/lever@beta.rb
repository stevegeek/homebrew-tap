# Pre-release channel, maintained by hand (GoReleaser skips the tap for
# pre-releases). Install: brew install stevegeek/tap/lever@beta
cask "lever@beta" do
  version "1.0.0-beta.4"

  on_macos do
    on_arm do
      sha256 "19a785750d7ee61f8c42969552ae634ed7c1d2dd6280d0e72613ec7649625bac"
      url "https://github.com/stevegeek/lever/releases/download/v#{version}/lever_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "6581f34c5baa017bd09431098826d4f3c442874d3775127a5aac34c0de897cb1"
      url "https://github.com/stevegeek/lever/releases/download/v#{version}/lever_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "904da9ca8a820f17bf810babb849bdf0a0d5d40b9013747138d77ef55d6569aa"
      url "https://github.com/stevegeek/lever/releases/download/v#{version}/lever_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "32a056654af2b31b84c51dde670ba249b3e05c32997fb79789ae9262d3b82419"
      url "https://github.com/stevegeek/lever/releases/download/v#{version}/lever_#{version}_linux_amd64.tar.gz"
    end
  end

  name "lever"
  desc "Jailed multi-agent orchestration for Claude Code"
  homepage "https://lever.to"

  conflicts_with cask: "lever"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "lever"
  binary "lever-tool-github"
  binary "lever-tool-whisper"
  binary "lever-tool-tts"

  postflight do
    if OS.mac?
      %w[lever lever-tool-github lever-tool-whisper lever-tool-tts].each do |bin|
        system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/#{bin}"]
      end
    end
  end

  # No zap stanza required

  caveats <<~EOS
    lever starts broker tools with PATH=/usr/local/bin:/usr/bin:/bin, not
    your shell PATH. Where Homebrew's bin directory is not on it (Apple
    Silicon, Linux), name each tool by absolute path in lever.yaml, e.g.
      command: [/opt/homebrew/bin/lever-tool-github, ...]
  EOS
end
