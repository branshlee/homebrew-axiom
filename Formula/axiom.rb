class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.12"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.12/axiom-0.1.12-aarch64-apple-darwin.tar.gz"
  sha256 "c214e820d754c4161dfe7dbc2f906d7cd29009db41797bc8859029e418000e57"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.12/axiom-0.1.12-aarch64-apple-darwin.tar.gz"
      sha256 "c214e820d754c4161dfe7dbc2f906d7cd29009db41797bc8859029e418000e57"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.12/axiom-0.1.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b4ce7e76429cebbcfdb489569c76fa6d169b8c3d86c8a42ec7a125af16a8655"
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
