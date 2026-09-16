class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.29"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.29/axiom-0.1.29-aarch64-apple-darwin.tar.gz"
  sha256 "c60849741f5912170a85e450cb7cba3ef30dfe97726bf4b5a1b330d72602b8b0"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.29/axiom-0.1.29-aarch64-apple-darwin.tar.gz"
      sha256 "c60849741f5912170a85e450cb7cba3ef30dfe97726bf4b5a1b330d72602b8b0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.29/axiom-0.1.29-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d6a731b0d8292f45243b88d35365c3b9593044de9e95f93f110b9c1a6278cce8"
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
