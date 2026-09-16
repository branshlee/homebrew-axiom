class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.26"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.26/axiom-0.1.26-aarch64-apple-darwin.tar.gz"
  sha256 "38d62cb2ea057efd658837dfb8742a4ac54b2a0f39c43ef8f56f3a60eacf1a39"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.26/axiom-0.1.26-aarch64-apple-darwin.tar.gz"
      sha256 "38d62cb2ea057efd658837dfb8742a4ac54b2a0f39c43ef8f56f3a60eacf1a39"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.26/axiom-0.1.26-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6a5f7057f0a8c28092d3916152e176f6ed5c335998b16c6059e70aa3b4b17b3f"
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
