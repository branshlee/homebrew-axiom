class Axiom < Formula
  desc "Experimental intelligence architecture: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"
  version "0.1.23"
  license :cannot_represent
  # default (macOS Apple Silicon); Linux overrides below
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.23/axiom-0.1.23-aarch64-apple-darwin.tar.gz"
  sha256 "04d47b55337208ee27abea109c2dad98f86b504655ff6ca1ddc7553b495602b9"

  on_macos do
    on_arm do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.23/axiom-0.1.23-aarch64-apple-darwin.tar.gz"
      sha256 "04d47b55337208ee27abea109c2dad98f86b504655ff6ca1ddc7553b495602b9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.23/axiom-0.1.23-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f501f37ded0179a8ad0f3f9a55da86ff3d68890e66395416d36edc2cef6fc4df"
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
