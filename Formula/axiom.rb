class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.11"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.11/axiom-0.1.11-aarch64-apple-darwin.tar.gz"
  sha256 "a3cdd51048bf5ee4a55a998929e610369e50f9a4d54d1517c61dfc90d008f321"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.11/axiom-0.1.11-aarch64-apple-darwin.tar.gz"
      sha256 "a3cdd51048bf5ee4a55a998929e610369e50f9a4d54d1517c61dfc90d008f321"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.11/axiom-0.1.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b1a4f1ea2fc0ca901c8ba1b466d5e645ac94c81b78f385c1b552657d24ee058a"
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
