class AxiomFull < Formula
  desc "Axiom with a knowledge snapshot: start from what an instance has already learned"
  homepage "https://github.com/branshlee/homebrew-axiom"
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.29/axiom-knowledge-0.1.29.tar.gz"
  sha256 "6e01b254ac22bf8e49771af41c66a4cfcab667d67cd499b3889f6ea75f2f95bd"
  version "0.1.29"
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
