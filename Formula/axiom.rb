class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.28"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.28/axiom-0.1.28-aarch64-apple-darwin.tar.gz"
  sha256 "c3cc057033532412228f84bea36dd0e1eaf38d4618f79f0f7b644394c69c9a08"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.28/axiom-0.1.28-aarch64-apple-darwin.tar.gz"
      sha256 "c3cc057033532412228f84bea36dd0e1eaf38d4618f79f0f7b644394c69c9a08"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.28/axiom-0.1.28-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ca9bc75c498187274afd0492020fcb41ab65f3b2bcaaaaeebb78918de67f49f3"
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
