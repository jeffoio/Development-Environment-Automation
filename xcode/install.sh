# !/bin/bash

mas install 497799835

sudo xcodebuild -license accept

open /Applications/Xcode.app

# copy xcode themes
mkdir ~/Library/Developer/Xcode/FontAndColorThemes
cp ./xcode/DRLColors.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes
cp ./xcode/One\ Dark.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes
cp ./xcode/WWDC\ 2016.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes
cp ./xcode/San\ Jose.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes
