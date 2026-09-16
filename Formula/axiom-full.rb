class AxiomFull < Formula
  desc "Axiom with a knowledge snapshot: start from what an instance has already learned"
  homepage "https://github.com/branshlee/homebrew-axiom"
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.15/axiom-knowledge-0.1.15.tar.gz"
  sha256 "6bc5b49aef23624eb4db71569c45e3c9bec5b6d942fe7057b015c97b7e086502"
  version "0.1.15"
  license :cannot_represent

  depends_on "branshlee/axiom/axiom"

  def install
    (pkgshare/"knowledge").install Dir["*"]
  end

  def caveats
    <<~EOS
      Seed a home directory with the bundled knowledge and start a session:
        axiom init --from #{opt_pkgshare}/knowledge
        axiom
      The snapshot is a content-addressed store; seeding an existing home only adds objects.
    EOS
  end

  test do
    assert_predicate pkgshare/"knowledge/events.log", :exist?
  end
end
