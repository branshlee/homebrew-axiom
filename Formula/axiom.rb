class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.9"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.9/axiom-0.1.9-aarch64-apple-darwin.tar.gz"
  sha256 "61e4ffc08ec3952a1184683a10cd2ec16c23a45893ef7f67b616eb454198e2d7"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.9/axiom-0.1.9-aarch64-apple-darwin.tar.gz"
      sha256 "61e4ffc08ec3952a1184683a10cd2ec16c23a45893ef7f67b616eb454198e2d7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.9/axiom-0.1.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3ee57ad76e453bb81a10d6ea0086ae7c9e1150fb393d6775b8cbb4d6552333f7"
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
