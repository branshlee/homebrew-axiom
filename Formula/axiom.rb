class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.19"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.19/axiom-0.1.19-aarch64-apple-darwin.tar.gz"
  sha256 "52d20fd449fb03ad69cf53da7c2fa366865279d4a71c0f3db2231ef1e982bfbc"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.19/axiom-0.1.19-aarch64-apple-darwin.tar.gz"
      sha256 "52d20fd449fb03ad69cf53da7c2fa366865279d4a71c0f3db2231ef1e982bfbc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.19/axiom-0.1.19-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d8a601d274d2f94267716ee523fdaf18ab364ff71fbb42d3892db426d078b875"
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
