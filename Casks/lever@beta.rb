# Pre-release channel, maintained by hand (GoReleaser skips the tap for
# pre-releases). Install: brew install stevegeek/tap/lever@beta
cask "lever@beta" do
  version "1.0.0-beta.1"

  on_macos do
    on_arm do
      sha256 "47111f0720f7dfcb53f562df11773a4aa18b5db88a2cbb2ffa42c7ada9f013c3"
      url "https://github.com/stevegeek/lever/releases/download/v#{version}/lever_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "b70dcc40a4298811774e99db09a93e9fe536ad27f03efde836a55d2aa4acf832"
      url "https://github.com/stevegeek/lever/releases/download/v#{version}/lever_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "7a295724831b53320dd380d95f15a921ee0f8878d4323c864c857d37bd56feb9"
      url "https://github.com/stevegeek/lever/releases/download/v#{version}/lever_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "a627946a519361842572ac8e2c2bcc6a8da007f6674c4ba6bd9db4b0fce79ca0"
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
