class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.2/axiom-0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "fe2ba8456b8097f3137a845323e45e7d493a32f033f616f882d86eab6694c08c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.2/axiom-0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7ebdcf41fbbfeb47e0d2a03167ee244ed0742399c644041605dea3a1f0723869"
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
