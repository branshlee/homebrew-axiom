class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.30"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.30/axiom-0.1.30-aarch64-apple-darwin.tar.gz"
  sha256 "8cfa456de3ac78fd02d4208bf78c8115f07e4f6e3aa9678c93fcdaaeeaec58b9"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.30/axiom-0.1.30-aarch64-apple-darwin.tar.gz"
      sha256 "8cfa456de3ac78fd02d4208bf78c8115f07e4f6e3aa9678c93fcdaaeeaec58b9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.30/axiom-0.1.30-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "65258cc153b29a8cf4a82be309e4cdf57d5356b1b20d0e64ec972e2198965d9c"
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
