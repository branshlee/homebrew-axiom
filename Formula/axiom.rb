class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.1/axiom-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "a03e9a023aae43ed5e72aa204bf93ec875806665a917c5057ebdff7e235b2203"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.1/axiom-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a49414f4710bd8b73e792dacd631a51854701197a05087a2a7f31300d3a44bc3"
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
