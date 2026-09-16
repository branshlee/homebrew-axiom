class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.17"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.17/axiom-0.1.17-aarch64-apple-darwin.tar.gz"
  sha256 "4e36f867172df7e38720e7d715f2537602f6eed7f02d1c57d2bb5d282f51c274"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.17/axiom-0.1.17-aarch64-apple-darwin.tar.gz"
      sha256 "4e36f867172df7e38720e7d715f2537602f6eed7f02d1c57d2bb5d282f51c274"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.17/axiom-0.1.17-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d924749efcbb76a92bb03e0c176278873113d4bd5c97dc5d20cc5bf8f7d7865d"
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
