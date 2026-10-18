# Alien6 Studio Homebrew tap

Official Homebrew formulae for Alien6 Studio software.

## Available software

| Formula | Software | Supported platform |
| --- | --- | --- |
| `apizr` | [Apizr](https://apizr.outerspace.sh/) — Python analysis and governed application interfaces | Apple Silicon macOS |

## Installation

```sh
brew tap alien6-studio/tap
brew install alien6-studio/tap/apizr
```

Use the fully qualified `alien6-studio/tap/<formula>` name to select software
from this tap. Application documentation is linked in the catalog above.

## Maintaining the tap

- Keep one formula per tool under `Formula/`, with its own upstream release and supported platforms.
- Use stable release artifacts, verified SHA-256 checksums and an explicit license.
- Add style, strict audit and installation tests for each new formula.
- Submit changes through a pull request with signed-off commits (`git commit -s`).

The [Apizr formula](Formula/apizr.rb) is generated with its upstream publication
renderer. Its [release receipt](formula-source.json) records the version, source
and build-input hashes. The [verification workflow](.github/workflows/verify.yml)
audits and installs it on a hosted Apple Silicon Mac. Optional Apizr plugins are
managed separately by Apizr.

Report packaging and installation problems in this repository; application issues
belong in the corresponding software project.
