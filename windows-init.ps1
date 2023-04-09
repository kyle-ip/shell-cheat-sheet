# WSL
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
wsl --set-default-version 2
wsl --install


# Scoop
$env:SCOOP='C:\Scoop\LocalApps'
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
$env:SCOOP_GLOBAL='C:\Scoop\GlobalApps'
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')
Set-ExecutionPolicy RemoteSigned -scope CurrentUser

Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

scoop install sudo
sudo scoop install 7zip git innounp dark -g

# scoop checkup
# Add-MpPreference -ExclusionPath 'C:\Scoop\LocalApps'
# Add-MpPreference -ExclusionPath 'C:\Scoop\GlobalApps'
# Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

scoop bucket add extras
scoop bucket add versions
scoop bucket add nightlies
scoop bucket add nirsoft
scoop bucket add php
scoop bucket add nerd-fonts
scoop bucket add nonportable
scoop bucket add java
scoop bucket add games
scoop bucket add jetbrains
scoop bucket add dorado https://github.com/chawyehsu/dorado
scoop bucket add Ash258 https://github.com/Ash258/Scoop-Ash258.git
scoop bucket add pleiades https://github.com/jfut/scoop-pleiades.git
scoop bucket add Scoop-Apps https://github.com/ACooper81/scoop-apps
scoop bucket add scoop-zapps https://github.com/kkzzhizhou/scoop-zapps
scoop bucket add lemon https://github.com/hoilc/scoop-lemon
scoop bucket add raresoft https://github.com/L-Trump/scoop-raresoft

scoop install aria2 -g
scoop config aria2-max-connection-per-server 16
scoop config aria2-split 16
scoop config aria2-min-split-size 1M


# scoop search <name>
# scoop status
# scoop reset <name>@<version>
# scoop hold <name>
# scoop update *
# scoop install <name>
# scoop install -g <name>
# scoop install extras/<name>
# scoop uninstall <name>
# scoop uninstall -g <name>
