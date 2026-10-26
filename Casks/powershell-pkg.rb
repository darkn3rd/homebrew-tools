# PowerShell itself is MIT-licensed (Microsoft/PowerShell) - see
#  https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt.
cask "powershell-pkg" do
  arch arm: "arm64", intel: "x64"

  version "7.6.9"
  sha256 arm:   "9002562086ad18dcdc4a1156f6cd6467cfb5a91b28206e56491212193b68e5e6",
         intel: "c599b3859dd199e223e237b008b6564961791dd2d849b96296fe4a63fbaa59dc"

  url "https://github.com/PowerShell/PowerShell/releases/download/v#{version}/powershell-#{version}-osx-#{arch}.pkg"
  name "PowerShell"
  desc "Command-line shell and scripting language"
  homepage "https://github.com/PowerShell/PowerShell"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on :macos

  pkg "powershell-#{version}-osx-#{arch}.pkg"

  uninstall pkgutil: "com.microsoft.powershell"

  zap trash: [
    "~/.cache/powershell",
    "~/.config/powershell",
    "~/.local/share/powershell",
  ]

  caveats <<~EOS
    To use Homebrew in PowerShell, run the following in a PowerShell session:
      New-Item -Path (Split-Path -Parent -Path $PROFILE.CurrentUserAllHosts) -ItemType Directory -Force
      Add-Content -Path $PROFILE.CurrentUserAllHosts -Value '$(#{HOMEBREW_PREFIX}/bin/brew shellenv) | Invoke-Expression'
  EOS
end
