class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.18"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.18/axiom-0.1.18-aarch64-apple-darwin.tar.gz"
  sha256 "cca95c95ee5677565917ec206cfd2d14b83ff078da19bd5309ead9ac3616dbe3"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.18/axiom-0.1.18-aarch64-apple-darwin.tar.gz"
      sha256 "cca95c95ee5677565917ec206cfd2d14b83ff078da19bd5309ead9ac3616dbe3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.18/axiom-0.1.18-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1fede77d20b229a1f7ed2b9ea59140548361008ca3e9f128a7071bb147c3e426"
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
