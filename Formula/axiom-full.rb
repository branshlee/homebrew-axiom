class AxiomFull < Formula
  desc "Axiom with a knowledge snapshot: start from what an instance has already learned"
  homepage "https://github.com/branshlee/homebrew-axiom"
  url "https://github.com/branshlee/homebrew-axiom/releases/download/v0.1.25/axiom-knowledge-0.1.25.tar.gz"
  sha256 "88c5a47a16860e8efa8239c595ca2eb19969f8f0303b893f33e0e5486bced0f3"
  version "0.1.25"
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
