class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.27"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.27/axiom-0.1.27-aarch64-apple-darwin.tar.gz"
  sha256 "63235df70222a298c127422eb3f566629e2db0c7c99a0062bfdb87a19c2db73a"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.27/axiom-0.1.27-aarch64-apple-darwin.tar.gz"
      sha256 "63235df70222a298c127422eb3f566629e2db0c7c99a0062bfdb87a19c2db73a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.27/axiom-0.1.27-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ef420eabe936ce4f53aa46532aa61b1378cb82fe41ab5b25c2d78e63ba1f314e"
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
