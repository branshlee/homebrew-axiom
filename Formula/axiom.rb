class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.10"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.10/axiom-0.1.10-aarch64-apple-darwin.tar.gz"
  sha256 "5f9ab3653804b87874b4b114dd73b635fe6617e5e40d590d2533ed65efe8ff1b"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.10/axiom-0.1.10-aarch64-apple-darwin.tar.gz"
      sha256 "5f9ab3653804b87874b4b114dd73b635fe6617e5e40d590d2533ed65efe8ff1b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.10/axiom-0.1.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8f25fc0228e62487a340e5aee3e3b685bf7bb4d3f1f4458bd171a4877f3931f8"
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
