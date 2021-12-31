# !/bin/bash

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# install via brew
brew bundle --file=./Brewfile

# install font
cp -a ./fonts/. ~/Library/Fonts

# configure zsh
chmod 755 ./zsh/install.sh
xattr -d com.apple.quarantine ./zsh/install.sh
./zsh/install.sh

# copy iterm2 configuration
chmod 755 ./iterm2/install.sh
xattr -d com.apple.quarantine ./iterm2/install.sh
./iterm2/install.sh

# copy alfred configuration
chmod 755 ./alfred/install.sh
xattr -d com.apple.quarantine ./alfred/install.sh
./alfred/install.sh

# copy hammerspoon configuration
chmod 755 ./hammerspoon/install.sh
xattr -d com.apple.quarantine ./hammerspoon/install.sh
./hammerspoon/install.sh

# install xcode
chmod 755 ./xcode/install.sh
xattr -d com.apple.quarantine ./xcode/install.sh
./xcode/install.sh

# Change Git Default branch name
git config --global user.name jeffoio
git config --global user.email xorgus1234@gmail.com
git config --global core.precomposeunicode true
git config --global core.quotepath false

