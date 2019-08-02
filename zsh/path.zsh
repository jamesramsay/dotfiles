SYSTEM_PATH=$PATH
unset PATH

# keep these on separate lines to make changing their order easier
PATH=$HOME/.bin

# Zsh scripts and utils
PATH=$PATH:$HOME/.zsh/bin

# Common system paths
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:$SYSTEM_PATH

# Rust
PATH=$PATH:$HOME/.cargo/bin

# Yarn
PATH=$PATH:$HOME/.yarn/bin

# Go
GOPATH=$HOME/go
GOROOT=/usr/local/opt/go/libexec
PATH=$PATH:$GOPATH/bin
PATH=$PATH:$GOROOT/bin

# Haskell
PATH=$PATH:$HOME/.local/bin

# Python
PATH=$PATH:$HOME/Library/Python/3.6/bin

# Postgres (GitLab GDK)
PATH=$PATH:/usr/local/opt/postgresql@10/bin

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opt/icu4c/lib/pkgconfig

export PATH
export GOPATH
export GOROOT
export PKG_CONFIG_PATH
