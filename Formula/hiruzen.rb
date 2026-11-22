class Hiruzen < Formula
  desc "Your terminal assistant: suggests the next word as you type and learns how you work, on Windows, Linux and macOS"
  homepage "https://hiruzen.farhanmalhi.com/"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.2.1/hiruzen-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1f0b832743ba8fd331cfec316db28739738d945dc1594fb50f0b16c2785ccbe5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.2.1/hiruzen-cli-x86_64-apple-darwin.tar.xz"
      sha256 "73dc36896cce0a6a26443d5a3b1d52f2fedcdeb07efcba7d03edf8ebdebe3565"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.2.1/hiruzen-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c0b90d384f5f2727a5a798a6bc6338d3baf3e7deb5072c9ad42517792ed20f41"
    end
    if Hardware::CPU.intel?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.2.1/hiruzen-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9fd85de4984e01e3b89558352c18fb846602bd73823c9c2d025e9589a2b9795b"
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
