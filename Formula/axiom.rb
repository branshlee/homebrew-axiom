class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.31"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.31/axiom-0.1.31-aarch64-apple-darwin.tar.gz"
  sha256 "78f59c17f6d3b861f15c6e3c6db006966dad2f0dd1e6cd0bc4f551584ce40f98"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.31/axiom-0.1.31-aarch64-apple-darwin.tar.gz"
      sha256 "78f59c17f6d3b861f15c6e3c6db006966dad2f0dd1e6cd0bc4f551584ce40f98"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.31/axiom-0.1.31-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4fba12de138b22e8db9b03d5311782bfc4c84d60fb96f6ec8f0dcb787ef9d3be"
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
