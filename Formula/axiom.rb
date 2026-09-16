class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.16"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.16/axiom-0.1.16-aarch64-apple-darwin.tar.gz"
  sha256 "c240b606562010124656e192adac7b6f251dd48ffdd02cc8d245c5925cd5ca6c"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.16/axiom-0.1.16-aarch64-apple-darwin.tar.gz"
      sha256 "c240b606562010124656e192adac7b6f251dd48ffdd02cc8d245c5925cd5ca6c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.16/axiom-0.1.16-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "762c5ca31922a459d9774a100de1e3cd3250f3327a90ba570591038a285c3385"
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
