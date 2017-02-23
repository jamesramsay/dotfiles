# Initialise and create links
git submodule init
git submodule update
git pull --recurse-submodules

# zsh
ln -s "$PWD/HOME/.zshrc" "$HOME"
ln -s "$PWD/HOME/zsh" "$HOME/.zsh"
mkdir "$HOME/.zfunctions"
ln -s "$PWD/HOME/zsh/async/async.zsh" "$HOME/.zfunctions/async"
ln -s "$PWD/HOME/zsh/pure/pure.zsh" "$HOME/.zfunctions/prompt_pure_setup"

# tmux
ln -s "$PWD/HOME/.tmux.conf" "$HOME"

# alacritty
ln -s "$PWD/HOME/alacritty" "$HOME/.config/"

# nvim
ln -s "$PWD/HOME/nvim" "$HOME/.config/"
