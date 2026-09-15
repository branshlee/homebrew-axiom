class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.7"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.7/axiom-0.1.7-aarch64-apple-darwin.tar.gz"
  sha256 "0a8a9350f157dfd08f335363ce66752b39627d54e6b68b26abce9c07e927ad9c"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.7/axiom-0.1.7-aarch64-apple-darwin.tar.gz"
      sha256 "0a8a9350f157dfd08f335363ce66752b39627d54e6b68b26abce9c07e927ad9c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.7/axiom-0.1.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "315f56c3778a3a7359e42d3e60603c83d3e7cc3fdaeae026d23320f68d7109c3"
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
