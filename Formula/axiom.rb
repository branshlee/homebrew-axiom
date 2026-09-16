class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.25"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.25/axiom-0.1.25-aarch64-apple-darwin.tar.gz"
  sha256 "ac19449ce4ac8c90e5d7e1dd580c015eb15be97540612a89ddcea63699f03683"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.25/axiom-0.1.25-aarch64-apple-darwin.tar.gz"
      sha256 "ac19449ce4ac8c90e5d7e1dd580c015eb15be97540612a89ddcea63699f03683"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.25/axiom-0.1.25-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "15a90a62b2ee841c264c2490e812685833d4e6b0ee8a175e340aafb5dfa01d26"
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
