class Hiruzen < Formula
  desc "Dropdown autocomplete for your terminal: suggests the next word as you type, on Windows, Linux and macOS"
  homepage "https://www.hiruzen.farhanmalhi.com/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.1.0/hiruzen-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f8f1aa895a7e2e748247f4247dde766dd303d1a8af1ed7fd7d2ae815f12857ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.1.0/hiruzen-cli-x86_64-apple-darwin.tar.xz"
      sha256 "b726c795f9a7f6310124c5da2874f82445326d191add69f9986548e40ec0cc01"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.1.0/hiruzen-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9577689a7658f3c016d30c8d84b2b7589002f64dd9e31cbc3e639ae5665208c5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/farhanmalhi/hiruzen-cli/releases/download/v0.1.0/hiruzen-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b10c1478ed01f4d08ffc953cdeda77578ab64423b6eb8939767ecdf384e59da9"
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
