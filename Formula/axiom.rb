class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.21"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.21/axiom-0.1.21-aarch64-apple-darwin.tar.gz"
  sha256 "243eca9dc0dc4f3374785638e9be394ac56af9e32b428962d8f00fed2c6817ee"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.21/axiom-0.1.21-aarch64-apple-darwin.tar.gz"
      sha256 "243eca9dc0dc4f3374785638e9be394ac56af9e32b428962d8f00fed2c6817ee"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.21/axiom-0.1.21-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "17f624a6f108c1ea6a9afa9b557e7dfbcf17a00db3d53fb8cf72e8edf5bfffdb"
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
