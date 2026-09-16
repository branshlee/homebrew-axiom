class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.8"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.8/axiom-0.1.8-aarch64-apple-darwin.tar.gz"
  sha256 "382989b382c180c07e7e538ae58296fdd51249e76f4a4cb107cc2aff57f838b2"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.8/axiom-0.1.8-aarch64-apple-darwin.tar.gz"
      sha256 "382989b382c180c07e7e538ae58296fdd51249e76f4a4cb107cc2aff57f838b2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.8/axiom-0.1.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "244b51ecb64297d3152453c115fb3843bb6409d1909a43c43e4d4abfb8a6aa22"
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
