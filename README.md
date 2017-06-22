# dotfiles

## Installation

### Clone

```
git clone --recursive https://github.com/jamesramsay/dotfiles.git
```

### Dependencies

- [tmux](https://github.com/tmux/tmux)
- [neovim](https://neovim.io/)
- fixed-width font that includes the [Powerline glyphs](http://powerline.readthedocs.io/en/master/installation.html#fonts-installation)
  - You can use Powerline glyphs with any font and iTerm using this trick: http://blog.erikphansen.com/quick-tip-operator-mono-and-powerline/

### Install

```
./install        # installs everything on the local machine
./install --help # info on installing specific roles, force-installing etc
```

This sets up a local Python environment using the bundled virtualenv, bootstraps Ansible, and then uses Ansible to copy the dotfiles and configure the machine.

As a fallback strategy, in case the `install` script fails, you can symlink the dotfiles by hand with a command like the following:

```
for DOTFILE in $(find roles/dotfiles/files -maxdepth 1 -name '.*' | tail -n +2); do
  ln -sf $PWD/$DOTFILE ~
done
```

**Note:** The `ln -sf` command will overwrite existing files, but will fail to overwrite existing directories.

## Author

This repo is maintained by James Ramsay and is based on the repo by Greg Hurrell (https://github.com/wincent/wincent).

