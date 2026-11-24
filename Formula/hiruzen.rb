class Hiruzen < Formula
  desc "Your terminal assistant: suggests the next word as you type and learns how you work, on Windows, Linux and macOS"
  homepage "https://hiruzen.farhanmalhi.com/"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.3.0/hiruzen-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c4f498caed7aab545e107683d3537f93f494e50cac653c4d430afa281d3e6c3e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.3.0/hiruzen-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7daad29437c1086e7266a80cec4507f21b03bb79e01a0bc7137947089f8eabaa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.3.0/hiruzen-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0ae30b58d752e24b4cc8fb56f6ad084b944e1ab6a01fc22458ce3ebeb66bc974"
    end
    if Hardware::CPU.intel?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.3.0/hiruzen-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3749defc73063c84835c2a55c847f88fbfc9651b4b050b851b90e6e150117f14"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "hiruzen"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hiruzen"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hiruzen"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hiruzen"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
