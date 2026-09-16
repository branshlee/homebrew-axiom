class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.22"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.22/axiom-0.1.22-aarch64-apple-darwin.tar.gz"
  sha256 "3dfc120dc678443e8143ad2087ed1ad64a57f55ee5018ddb5f19f13dd67aee99"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.22/axiom-0.1.22-aarch64-apple-darwin.tar.gz"
      sha256 "3dfc120dc678443e8143ad2087ed1ad64a57f55ee5018ddb5f19f13dd67aee99"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.22/axiom-0.1.22-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "552ea0f24cef9dd63e81a4c9742ee6d525c74a47c59c0ada7c145a4a74a2e0a7"
    end
  end

  def install
    bin.install "axiom"
  end

  def caveats
    <<~EOS
      Set up a home directory and start a session:
        axiom init
        axiom
      Everything lives under ~/.axiom (or $AXIOM_HOME).
    EOS
  end

  test do
    ENV["AXIOM_HOME"] = testpath/"home"
    system bin/"axiom", "init"
    assert_predicate testpath/"home/data/worlds", :exist?
  end
end
