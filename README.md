# Interwarp, versions publiées

Terminal macOS natif pour les sessions Claude Code, rangées par projet. Ce dépôt ne contient que l'app compilée :
les zips (dans les [Releases](https://github.com/Leozerbib/interwarp-releases/releases)), le manifeste de la
dernière version (`manifest.json`) et la cask Homebrew (`Casks/interwarp.rb`). Le code source est privé.

Chaque fichier est écrit par la publication automatique d'une version : ne le modifie pas à la main.

## Installer

macOS 14 ou plus récent, Apple Silicon. Homebrew installé.

```sh
brew tap leozerbib/interwarp https://github.com/Leozerbib/interwarp-releases
brew trust leozerbib/interwarp
brew install --cask interwarp
```

`brew trust` ne se fait qu'une fois : les versions récentes de Homebrew refusent de charger une cask venue d'un
tap tiers tant qu'on ne l'a pas approuvé.

L'app va dans `/Applications`. Sans droits admin : `brew install --cask --appdir=~/Applications interwarp`
(ou `export HOMEBREW_CASK_OPTS="--appdir=~/Applications"` dans ton `~/.zprofile`, pour les mises à jour aussi).

## Premier lancement : la quarantaine

Interwarp est signé par un certificat auto-signé (« Interwarp Dev »), sans notarisation Apple. Homebrew met
l'app téléchargée en quarantaine ; Gatekeeper peut alors refuser de l'ouvrir. Si c'est le cas, lève la
quarantaine de cette version, une fois :

```sh
xattr -dr com.apple.quarantine /Applications/Interwarp.app
```

ou ouvre Réglages Système › Confidentialité et sécurité, puis « Ouvrir quand même ». Une mise à jour remet la
quarantaine sur la nouvelle version : si macOS bloque de nouveau, refais ce geste.

Sur un Mac géré par une entreprise, si un outil de l'entreprise bloque l'app, passe par l'IT : ne contourne rien.

## Mettre à jour

```sh
brew update
brew upgrade --cask interwarp
```

Quitte Interwarp avant (⌘Q) : ses sessions s'arrêteraient. Toutes les versions sont signées par le même
certificat : le Trousseau et les autorisations de macOS reconnaissent l'app d'une version à l'autre.

## Vérifier ce que tu as installé

```sh
codesign -dv --verbose=2 /Applications/Interwarp.app 2>&1 | grep -E 'Identifier|Authority'
shasum -a 256 ~/Library/Caches/Homebrew/downloads/*Interwarp-*.zip
```

`Authority=Interwarp Dev`, et l'empreinte du zip égale à `sha256` dans `manifest.json` et dans les notes de la
Release. L'empreinte SHA-1 du certificat est dans `manifest.json` (`certificatSHA1`).

## Désinstaller

```sh
brew uninstall --cask interwarp          # l'app seulement
brew uninstall --zap --cask interwarp    # plus préférences, caches et journaux
```

Tes données (`~/Library/Application Support/Interwarp`) restent en place dans les deux cas : supprime ce
dossier à la main si tu n'en veux plus. Les entrées d'Interwarp dans le Trousseau aussi.

## Manifeste

`https://raw.githubusercontent.com/Leozerbib/interwarp-releases/main/manifest.json` décrit la dernière version :
`version`, `build` (ne fait qu'augmenter), `tag`, `url` du zip, `sha256`, `taille` en octets, `macosMinimum`,
`bundleId`, `certificatSHA1`, `publieLe` (UTC).
