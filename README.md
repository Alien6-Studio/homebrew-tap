# Alien6 Homebrew tap

Official Homebrew Formula for [Apizr](https://apizr.outerspace.sh/).

```sh
brew tap alien6-studio/tap
brew install alien6-studio/tap/apizr
brew test alien6-studio/tap/apizr
apizr --version
```

Apizr 0.4.3 installs the core on qualified physical Apple Silicon macOS with
Homebrew Python 3.14 and Pydantic. Optional MCP, OCI and Attest plugins remain
Apizr-managed, isolated environments outside the Formula prefix.
Intel macOS is Tier 3 and not qualified. Linux Homebrew runtime is not qualified.

The Formula is generated without semantic edits from immutable
[Apizr v0.4.3](https://github.com/Alien6-Studio/outerspace-apizr/releases/tag/v0.4.3),
source `cfaa5108c37ab9324297bbe5b38d90d537ea57ad`.
Its source archive SHA-256 is
`822316e92a313f46f99dd32fda636c377b578b141a00aa63168475ef450ed24f`.

Changes use pull requests with a Developer Certificate of Origin sign-off.
Regenerate the Formula with the release's publication-mode renderer and verify
style, readall, strict online audit and a real Apple Silicon install/test before merging.
This tap does not publish plugin Formulae or submit to Homebrew/core.
