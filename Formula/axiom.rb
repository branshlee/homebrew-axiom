class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.15"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.15/axiom-0.1.15-aarch64-apple-darwin.tar.gz"
  sha256 "3acefd443418d9e3b1cff170386a413b81fcd9f502109408cb57d0ba0cc0083c"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.15/axiom-0.1.15-aarch64-apple-darwin.tar.gz"
      sha256 "3acefd443418d9e3b1cff170386a413b81fcd9f502109408cb57d0ba0cc0083c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.15/axiom-0.1.15-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "266b4dfdc71147a6c3f541e248ba46e597b8b5fdfa21bb34be01b14524477e42"
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
