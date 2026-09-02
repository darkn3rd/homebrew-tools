# PowerShell itself is MIT-licensed (Microsoft/PowerShell) - see
#  https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt.
cask "powershell" do
  arch arm: "arm64", intel: "x64"

  version "7.6.5"
  sha256 arm:   "6ea58f4e91ab2df133ac18a42e291e4e870a623e3c5ab6f8368259cd9ac22770",
         intel: "abebd1e94af6c98fdc8f2a1a51f112e8589d9624155b1cd7e42f6fef5ef7ae32"

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
