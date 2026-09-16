class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.32"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.32/axiom-0.1.32-aarch64-apple-darwin.tar.gz"
  sha256 "c70ec845169c4e89f1db078e70fdf7ffc6bb76e388f34d2abdcf203f9d44f511"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.32/axiom-0.1.32-aarch64-apple-darwin.tar.gz"
      sha256 "c70ec845169c4e89f1db078e70fdf7ffc6bb76e388f34d2abdcf203f9d44f511"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.32/axiom-0.1.32-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "642f07bf87c681fe61d82ef9e69364a42e1cf5e685376a7b28c9d39eb64bbf70"
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
