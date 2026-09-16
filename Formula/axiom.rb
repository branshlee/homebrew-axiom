class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.24"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.24/axiom-0.1.24-aarch64-apple-darwin.tar.gz"
  sha256 "d4cb810ba3ca505812f3047d1bcff5702069c57521a491e3a614a633510e74d2"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.24/axiom-0.1.24-aarch64-apple-darwin.tar.gz"
      sha256 "d4cb810ba3ca505812f3047d1bcff5702069c57521a491e3a614a633510e74d2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.24/axiom-0.1.24-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ac993a7e1720db1a7b551977e03ac00a895b7447a67e0dc1b8dd0e0c10056f3f"
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
