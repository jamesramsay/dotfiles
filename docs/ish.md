# iSH

## Install `apk` 

Source: https://github.com/ish-app/ish/wiki/Installing-apk-on-the-App-Store-Version

```
wget http://dl-cdn.alpinelinux.org/alpine/v3.12/main/x86/apk-tools-static-2.10.5-r1.apk
tar xf apk-tools-static-2.10.5-r1.apk sbin/apk.static
./sbin/apk.static add apk-tools
```

## Minimal packages

```
apk add sudo \
  git \
  zsh \
  neovim \
  tmux \
  openssh \
  openssh-client
```

## Create user

```
adduser jramsay
adduser jramsay wheel
echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
```

```
vi /etc/passwd
# Edit default prompt
```

## Setup dotfiles

```
su -l jramsay
git clone https://

./dotfiles/script/setup
# remove submodules!
```

## Configure SSH

```
ssh-keygen -A
```

Change port to 22000

## TIP: run in background

```
cat /dev/location > /dev/null &
```

