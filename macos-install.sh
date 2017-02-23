# Command line tools
xcode-select --install

# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

# zsh
brew install zsh
brew install tmux

# neovim
# - vim-plug: plugin manager
brew install neovim/neovim/neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# git
brew install git
git config --global user.name "James Ramsay"
git config --global user.email james@jramsay.com.au
brew install tig

# node
brew install node
brew install -g n

# utlities
brew install ripgrep # faster grep: https://github.com/BurntSushi/ripgrep
brew install the_silver_searcher # faster ack: https://github.com/ggreer/the_silver_searcher
brew install jq # command line JSON processor: https://github.com/stedolan/jq
