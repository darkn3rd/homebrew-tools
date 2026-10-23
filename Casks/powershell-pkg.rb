# PowerShell itself is MIT-licensed (Microsoft/PowerShell) - see
#  https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt.
cask "powershell-pkg" do
  arch arm: "arm64", intel: "x64"

  version "7.6.8"
  sha256 arm:   "b939d0e954d219571bb670517ad1d1ea06127aff9e9a36343c687ffc00407eab",
         intel: "5fe50da19a57039fd19aab0109ecf3a0eb4c6a8f9e7e2355a81b6e6c9b05e83d"

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
