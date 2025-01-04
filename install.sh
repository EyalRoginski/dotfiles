# You should set your terminal to a compatible font first - I use 0xProto Nerd Font

apt update

if !(gcc --version); then
    apt install gcc
fi

if !(stow --version); then
    apt install stow
fi

# Install zsh
if !(zsh --version); then
    apt install zsh
fi

# Set zsh to be default shell
if !(echo $SHELL | grep -q zsh); then
    chsh -s $(which zsh)
fi

# Install oh-my-zsh
if [ ! -f $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install p10k
if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install TPM
if [ ! -d $HOME/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install latest Neovim
if !(nvim --version); then
    snap install nvim --classic
fi


stow -t $HOME nvim
stow -t $HOME shell
