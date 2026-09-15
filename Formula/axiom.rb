class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.3/axiom-0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "39ea217108fd36dcc590c346ecd372350c16af8388e6f6a91da80f8e532c4800"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.3/axiom-0.1.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b3585ba01194b4ce6cad8ed5bed83cc67ae72784841fe7061d735bcffaf0cd89"
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
