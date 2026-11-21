class Hiruzen < Formula
  desc "Dropdown autocomplete for your terminal: suggests the next word as you type, on Windows, Linux and macOS"
  homepage "https://hiruzen.farhanmalhi.com/"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.2.0/hiruzen-cli-aarch64-apple-darwin.tar.xz"
      sha256 "23704d8e1bc0976d042e4535f193c7bfe983c04ce5367d44c80ed5273bd36313"
    end
    if Hardware::CPU.intel?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.2.0/hiruzen-cli-x86_64-apple-darwin.tar.xz"
      sha256 "063379146d41dabf8e270f3867b14fc9aafa514bfcffbaf096a517cfbdc7474f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.2.0/hiruzen-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "50334f7600cb87f4b1106c4e34a90604841f0b76452ca691195656905ffdd21c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.2.0/hiruzen-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "918a410d9738be1555b6bb3df726b9b326ae882e498a6d703e5cf780a7e76a52"
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
