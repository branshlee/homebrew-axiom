class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.20"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.20/axiom-0.1.20-aarch64-apple-darwin.tar.gz"
  sha256 "531ce93a8f7a1a469adb5392a9a01810ff4356c367c08efa04abb6e98fae3a5a"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.20/axiom-0.1.20-aarch64-apple-darwin.tar.gz"
      sha256 "531ce93a8f7a1a469adb5392a9a01810ff4356c367c08efa04abb6e98fae3a5a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.20/axiom-0.1.20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "36bfd7196de9433f3189da9e0ee1d18c565bae45f7c2d780824aaf99e6ddc911"
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
