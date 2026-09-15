cask "axiom" do
  version "0.1.5"
  sha256 "484a84370cc491bc2eb872fb850e61061e66c0d70ec93fe15f9656d591b1993e"

  url "https://github.com/branshlee/homebrew-axiom/releases/download/v#{version}/axiom-#{version}-aarch64-apple-darwin.tar.gz"
  name "Axiom"
  desc "Self-evolving induction engine: discovers, folds and re-represents executable laws"
  homepage "https://github.com/branshlee/homebrew-axiom"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64

  binary "axiom"

  zap trash: "~/.axiom"
end
