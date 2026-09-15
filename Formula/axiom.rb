class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.5"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.5/axiom-0.1.5-aarch64-apple-darwin.tar.gz"
  sha256 "484a84370cc491bc2eb872fb850e61061e66c0d70ec93fe15f9656d591b1993e"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.5/axiom-0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "484a84370cc491bc2eb872fb850e61061e66c0d70ec93fe15f9656d591b1993e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.5/axiom-0.1.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "07b697748b561e1ef72ff6c2e5162895e8d46342390d4ee9bc05aa0813dacb79"
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
