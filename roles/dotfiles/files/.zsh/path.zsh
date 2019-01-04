SYSTEM_PATH=$PATH
unset PATH

# keep these on separate lines to make changing their order easier
PATH=$HOME/bin

# Zsh scripts and utils
PATH=$PATH:$HOME/.zsh/bin

# Common system paths
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:$SYSTEM_PATH

# Yarn global path
PATH=$PATH:$HOME/.yarn/bin

# Go language
GOPATH=$HOME/go
GOROOT=/usr/local/opt/go/libexec
PATH=$PATH:$GOPATH/bin
PATH=$PATH:$GOROOT/bin

# Haskell Stack
PATH=$PATH:$HOME/.local/bin

# Python
PATH=$PATH:$HOME/Library/Python/3.6/bin

# Postgres (GitLab GDK)
PATH=$PATH:/usr/local/opt/postgresql@9.6/bin

export PATH
export GOPATH
export GOROOT
