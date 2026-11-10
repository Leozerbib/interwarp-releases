cask "interwarp" do
  version "1.0.0"
  sha256 "e3a7678299d8a3a0fbe8b85a322f50db9c28f20a557773d4c69a7974b48711cc"

  url "https://github.com/Leozerbib/interwarp-releases/releases/download/v#{version}/Interwarp-#{version}.zip"
  name "Interwarp"
  desc "Terminal natif pour les sessions Claude Code, rangées par projet"
  homepage "https://github.com/Leozerbib/interwarp-releases"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Interwarp.app"

  # ~/Library/Application Support/Interwarp n'est pas listé : il garde l'espace de travail, l'historique et,
  # sur le Mac qui publie, le trousseau de signature. Le supprimer reste un geste à faire à la main.
  zap trash: [
    "~/Library/Caches/io.github.leozerbib.interwarp",
    "~/Library/HTTPStorages/io.github.leozerbib.interwarp",
    "~/Library/Logs/Interwarp",
    "~/Library/Preferences/io.github.leozerbib.interwarp.plist",
    "~/Library/Saved Application State/io.github.leozerbib.interwarp.savedState",
  ]

  caveats <<~EOS
    Interwarp est signé par un certificat auto-signé (« Interwarp Dev »), sans notarisation Apple.
    Si macOS refuse de l'ouvrir au premier lancement, ou après une mise à jour, lève la quarantaine
    de cette version, une fois :
      xattr -dr com.apple.quarantine "#{appdir}/Interwarp.app"
    ou Réglages Système › Confidentialité et sécurité › « Ouvrir quand même ».
    Sur un Mac géré, si un outil de l'entreprise bloque l'app, passe par l'IT : ne contourne rien.

    Mise à jour : brew upgrade --cask interwarp
    Le certificat reste le même d'une version à l'autre : le Trousseau ne devrait rien redemander.
  EOS
end
