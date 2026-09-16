class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.13"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.13/axiom-0.1.13-aarch64-apple-darwin.tar.gz"
  sha256 "d7271bb32135617bd84f9809e0012b255adbb9309c3a201327a9fdb04715e77d"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.13/axiom-0.1.13-aarch64-apple-darwin.tar.gz"
      sha256 "d7271bb32135617bd84f9809e0012b255adbb9309c3a201327a9fdb04715e77d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.13/axiom-0.1.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1b47cdafa7a0a08c0befc794d9961ccc9d9ec7ef04feecd3aeb7e55cc0c905c9"
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
