# Darkn3rd Tools

A small Homebrew tap for casks/formulae that don't have another home.

## Casks

### powershell-pkg

Microsoft's PowerShell, installed from the official signed `.pkg` released
directly by the PowerShell team.

**Why this exists:** Homebrew removed the official `powershell` cask
([Homebrew/homebrew-cask#251326](https://github.com/Homebrew/homebrew-cask/pull/251326))
and pushed everyone toward a community-built formula instead
([PowerShell/PowerShell#26061](https://github.com/PowerShell/PowerShell/issues/26061)).
The stated reason was a long-standing Gatekeeper failure on the `.pkg`
installer, tracked for years in
[PowerShell/PowerShell#10874](https://github.com/PowerShell/PowerShell/issues/10874),
and Homebrew's own policy of disabling every cask that fails a Gatekeeper
check by 2026-09-01.

That reasoning no longer holds for current releases. Microsoft's macOS
`.pkg` installers are signed with a Developer ID Installer certificate
(Microsoft Corporation, team ID `UBF8T346G9`) and notarized by Apple - the
exact thing the cask was removed for not having. Verified directly against
the v7.6.5 release:

```sh
spctl --assess --verbose --type install ~/Downloads/powershell-7.6.5-osx-arm64.pkg
spctl --assess --verbose --type install ~/Downloads/powershell-7.6.5-osx-x64.pkg
```

Both the arm64 and x64 packages return `accepted`, `source=Notarized
Developer ID`. I'm making this cask available again because Homebrew's
removal is no longer justified by the facts: the package it was removed
over passes the exact check it was supposedly failing.

## How do I install these?

```
brew install --cask darkn3rd/tools/powershell-pkg
```

Or tap first, then install by name:

```
brew tap darkn3rd/tools
brew install --cask powershell-pkg
```

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "darkn3rd/tools"
cask "powershell-pkg"
```

## License

This repository (the tap itself - cask definitions, README, CI) is
[MPL-2.0](LICENSE).

That does **not** cover the software each cask installs - Cask DSL has no
`license` stanza to declare this per-cask (unlike Formula, which does), so
it's noted here instead:

* **powershell-pkg** - [MIT License](https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt), Microsoft/PowerShell.

## Documentation

`brew help`, `man brew`, or [Homebrew's documentation](https://docs.brew.sh).
