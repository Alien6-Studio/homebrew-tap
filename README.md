# Alien6 Homebrew tap

Official Homebrew Formula for [Apizr](https://apizr.outerspace.sh/).

```sh
brew tap alien6-studio/tap
brew install alien6-studio/tap/apizr
brew test alien6-studio/tap/apizr
apizr --version
```

Apizr 0.4.5 installs the core with Homebrew Python 3.14 and Pydantic.
Optional MCP, OCI and Attest plugins remain Apizr-managed, isolated environments
outside the Formula prefix. Managed plugin installation requires uv 0.12.0.

The Formula is generated without semantic edits from immutable
[Apizr v0.4.5](https://github.com/Alien6-Studio/outerspace-apizr/releases/tag/v0.4.5),
source `da74e6de5800eab9c275e42c5d4c24a59ac4fcbe`.
Its source archive SHA-256 is
`c4dfc1834bdcc885b87dfe0dda58743b41971ac64e58ad74caef7ea369d9b5c7`.
The publication renderer verified protected master provenance and the public
asset's identity. `formula-source.json` records the generated Formula and build-input hashes.

Apple Silicon macOS is the distribution target. The PR workflow checks style,
structure, strict online audit and a real installation/test of the public Formula
on a GitHub-hosted Apple Silicon VM. Hosted VM evidence is distinct from physical
Tier-1 host qualification; earlier physical release evidence keeps its original
source identity. Intel macOS is Tier 3 and not qualified. Linux Homebrew runtime
is not qualified.

Changes use pull requests with a Developer Certificate of Origin sign-off.
Regenerate the Formula with the release's publication-mode renderer and pass
style, readall, strict online audit and the Apple Silicon install/test before merging.
This tap does not publish plugin Formulae or submit to Homebrew/core.
