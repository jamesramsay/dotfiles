SYSTEM_PATH=$PATH
unset PATH

PATH=$HOME/.opt/bin

# Ruby
PATH=$PATH:/opt/homebrew/opt/ruby@2.7/bin
LDFLAGS=-L/opt/homebrew/opt/ruby@2.7/lib
CPPFLAGS=-I/opt/homebrew/opt/ruby@2.7/include
PKG_CONFIG_PATH=/opt/homebrew/opt/ruby@2.7/lib/pkgconfig

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
PATH=$PATH:/usr/local/opt/postgresql@11/bin

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opt/icu4c/lib/pkgconfig
# Node - Fast Node Manager
eval "$(fnm env)"

export PATH
export GOPATH
export GOROOT
export PKG_CONFIG_PATH
