# Alien6 Homebrew tap

Official Homebrew Formula for [Apizr](https://apizr.outerspace.sh/).

```sh
brew tap alien6-studio/tap
brew install alien6-studio/tap/apizr
brew test alien6-studio/tap/apizr
apizr --version
```

Apizr 0.4.2 installs the core on qualified physical Apple Silicon macOS with
Homebrew Python 3.14 and Pydantic. Optional MCP, OCI and Attest plugins remain
Apizr-managed, isolated environments outside the Formula prefix.
Intel macOS is Tier 3 and not qualified. Linux Homebrew runtime is not qualified.

The Formula is generated without semantic edits from immutable
[Apizr v0.4.2](https://github.com/Alien6-Studio/outerspace-apizr/releases/tag/v0.4.2),
source `a21cfd41eecc7ca3259e2fb72f6a028a288b9030`.
Its source archive SHA-256 is
`ca0348d7e16fd880271f10f62f1365fc52b5f264f856878426ae0628f7b51ed9`.

Changes use pull requests with a Developer Certificate of Origin sign-off.
Regenerate the Formula with the release's publication-mode renderer and verify
style, readall, strict online audit and a real Apple Silicon install/test before merging.
This tap does not publish plugin Formulae or submit to Homebrew/core.
