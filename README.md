# Alien6 Homebrew tap

Official Homebrew Formula for [Apizr](https://apizr.outerspace.sh/).

```sh
brew tap alien6-studio/tap
brew install alien6-studio/tap/apizr
brew test alien6-studio/tap/apizr
apizr --version
```

Apizr 0.4.4 installs the core with Homebrew Python 3.14 and Pydantic.
Optional MCP, OCI and Attest plugins remain Apizr-managed, isolated environments
outside the Formula prefix. Managed plugin installation requires uv 0.12.0.

The Formula is generated without semantic edits from immutable
[Apizr v0.4.4](https://github.com/Alien6-Studio/outerspace-apizr/releases/tag/v0.4.4),
source `46c573d7f808f8d491cde1062d474b145288697f`.
Its source archive SHA-256 is
`b536b1ddebae627315721f92645b48b59c6fa4e217ac76931cc41d412caed046`.
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
