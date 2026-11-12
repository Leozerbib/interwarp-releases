cask "interwarp" do
  version "1.4.0"
  sha256 "8db25af49a31047dea7227e4e9b82885b3f0543b091036a817002508134a2512"

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
    Les jetons des connecteurs survivent à la mise à jour : ils ne dépendent pas de la signature.
  EOS
end
