# !/bin/bash

#install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#zsh plugin
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# install zsh theme
sudo git clone https://github.com/romkatv/powerlevel10k.git /Users/$USER/.oh-my-zsh/themes/powerlevel10k

# copy my zsh settings
cp ./zsh/.zshrc ~/.zshrc
