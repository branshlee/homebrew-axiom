class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.33"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.33/axiom-0.1.33-aarch64-apple-darwin.tar.gz"
  sha256 "3fb1c861cae1a3a963cb23ebf775396e2bdd3d80cab6adc21b52a0117f7981f6"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.33/axiom-0.1.33-aarch64-apple-darwin.tar.gz"
      sha256 "3fb1c861cae1a3a963cb23ebf775396e2bdd3d80cab6adc21b52a0117f7981f6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.33/axiom-0.1.33-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a66f9de58c7605838197250f4494ce88b9c6159739dd2504aae31a3720011110"
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
