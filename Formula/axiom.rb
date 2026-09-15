class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.4"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.4/axiom-0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "a8e958eeb5daa608bef9150936e4cc8e9bbb64b44975b5141ff98bacf27e436e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.4/axiom-0.1.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6cc68739a40d3631175fc7600fe68f2f280effc12fadf5bcebc892e2e493ba7a"
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
