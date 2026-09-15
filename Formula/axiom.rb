class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.6"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.6/axiom-0.1.6-aarch64-apple-darwin.tar.gz"
  sha256 "a9888c978c79758dda8bc2120a3b7fdd2037a05dd4869237b1197ea05cebacd9"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.6/axiom-0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "a9888c978c79758dda8bc2120a3b7fdd2037a05dd4869237b1197ea05cebacd9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.6/axiom-0.1.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3a39e7d4ccfa8c9140c7cd11c30c4bf81a9da5cb6f3bbde20eb5f3ac5a5ad2f0"
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
