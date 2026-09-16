class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.14"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.14/axiom-0.1.14-aarch64-apple-darwin.tar.gz"
  sha256 "7c46446ea6a57dfeb3d26ced3c96aa686690ddb04b33f0cf577e36544ded54e4"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.14/axiom-0.1.14-aarch64-apple-darwin.tar.gz"
      sha256 "7c46446ea6a57dfeb3d26ced3c96aa686690ddb04b33f0cf577e36544ded54e4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.14/axiom-0.1.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d2452ac5b219be48da03413d99020a33acfad65c898eca3ab42ae30a84d477dd"
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
