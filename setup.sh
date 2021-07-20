#!/usr/bin/env zsh

add_or_update_asdf_plugin() {
  local name="$1"
  local url="$2"

  if ! asdf plugin-list | grep -Fq "$name"; then
    asdf plugin-add "$name" "$url"
  else
    asdf plugin-update "$name"
  fi
}

install_asdf_language() {
  local language="$1"
  local version
  version="$(asdf list-all "$language" | grep -v "[a-z]" | tail -1)"

  if ! asdf list "$language" | grep -Fq "$version"; then
    asdf install "$language" "$version"
    asdf global "$language" "$version"
  fi
}

echo "Creating an SSH key for you..."
ssh-keygen -t rsa

echo "Please add this public key to Github \n"
echo "https://github.com/account/ssh \n"
read -p "Press [Enter] key after this..."

echo "Installing XCode CLI utils..."
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing Git..."
brew install git

echo "Setting up Git..."

git config --global user.name "Simone D'Avico"
git config --global user.email $1

if test ! $(which fnm); then
  echo "Installing Node.js..."
  brew install fnm
  fnm install --lts
  fnm eval
fi

echo "Installing other brew stuff..."

packages=(
  asdf
  bat
  cloc
  exercism
  jq
  kubectx
  kubernetes-cli
  mas
  openssl
  sdkman
  skhd
  stern
  tree
  watch
  watchman
  yabai
  z
)

brew install ${packages[@]}

echo "Cleaning up brew..."
brew cleanup

echo "Setting up asdf plugins..."

add_or_update_asdf_plugin "erlang" "https://github.com/asdf-vm/asdf-erlang.git"
add_or_update_asdf_plugin "elixir" "https://github.com/asdf-vm/asdf-elixir.git"

echo "Setting up Erlang and Elixir..."

install_asdf_language "erlang"
install_asdf_language "elixir"

echo "Installing fonts..."
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/simonedavico/dotfiles/master/fonts.sh)"

#Install Zsh & Oh My Zsh
echo "Installing Oh My Zsh..."
curl -L http://install.ohmyz.sh | sh

echo "Setting up Zsh plugins..."
cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

echo "Installing powerline10k for oh-my-zsh..."

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Creating development directory..."

mkdir -p ~/Development

echo "Cloning dotfiles repository..."

pushd ~/Development

git clone git@github.com:simonedavico/dotfiles.git

echo "Symlinking dotfiles..."

ln -sf ~/Development/dotfiles/.zshrc ~/.zshrc
ln -sf ~/Development/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -sf ~/Development/yabai/.yabairc ~/.yabairc
ln -sf ~/Development/yabai/scripts ~/.yabai/scripts
ln -sf ~/Development/yabai/.config/karabiner ~/.config/karabiner
ln -sf ~/Development/yabai/.config/skhd ~/.config/skhd

chmod +x ~/.yabai/scripts/*.sh

popd

# Apps
apps=(
  alfred
  discord
  docker
  firefox
  google-chrome
  iterm2
  jetbrains-toolbox
  keeweb
  maccy
  qlmarkdown
  qlstephen
  spotify
  suspicious-package
  tableplus
  transmission
  vlc
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps with Cask..."
brew install --cask ${apps[@]}

brew cask alfred link

brew cask cleanup
brew cleanup

echo "Installing apps from App Store with mas"

mas_apps=(
  937984704 # Amphetamine 
  409203825 # Numbers
  409183694 # Keynote
)

mas install ${mas_apps[@]}

echo "Setting some Mac settings..."

#"Disabling system-wide resume"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

#"Disabling automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

#"Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

#"Disabling OS X Gate Keeper"
#"(You'll be able to install any app you want from here on, not just Mac App Store apps)"
sudo spctl --master-disable
sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
defaults write com.apple.LaunchServices LSQuarantine -bool false

#"Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

#"Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

#"Saving to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

#"Check for software updates daily, not just once per week"
# defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

#"Disable smart quotes and smart dashes as they are annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

#"Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

#"Disabling press-and-hold for keys in favor of a key repeat"
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

#"Setting trackpad & mouse speed to a reasonable number"
# defaults write -g com.apple.trackpad.scaling 2
# defaults write -g com.apple.mouse.scaling 2.5

#"Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

#"Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

#"Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

#"Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

#"Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

#"Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

#"Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

#"Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

#"Setting Dock to auto-hide and removing the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

#"Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

#"Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
# defaults write com.apple.terminal StringEncodings -array 4
# defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
# defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

#"Preventing Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

#"Disable the sudden motion sensor as its not useful for SSDs"
# sudo pmset -a sms 0

#"Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
# sudo pmset -a standbydelay 86400

#"Disable annoying backswipe in Chrome"
# defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

#"Setting screenshots location to ~/Desktop"
defaults write com.apple.screencapture location -string "$HOME/Desktop"

#"Setting screenshot format to PNG"
defaults write com.apple.screencapture type -string "png"

#"Use `~/Downloads/Incomplete` to store incomplete downloads"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Incomplete"

#"Don't prompt for confirmation before downloading"
defaults write org.m0k.transmission DownloadAsk -bool false

#"Trash original torrent files"
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

#"Hide the donate message"
defaults write org.m0k.transmission WarningDonate -bool false

#"Hide the legal disclaimer"
defaults write org.m0k.transmission WarningLegal -bool false

#"Disable 'natural' (Lion-style) scrolling"
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

killall Finder

echo "All packages installed! A few manual steps required: \n"
echo "* Restore dotfiles \n"
echo "* Complete yabai installation (instructions at https://github.com/koekeishiya/yabai/wiki) \n"
echo "* Enable reduced motion in macOS Accessibility settings \n"
echo "* Setup JetBrains apps from the Toolbox \n"
echo "* Install the JVM via sdkman \n"
echo "* Upgrade zsh: `brew install zsh`, add to `/etc/shells`, then run `chsh -s $(which zsh)`"
