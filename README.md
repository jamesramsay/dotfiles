# dotfiles

My dotfiles for ZSH, tmux and vim, influenced by many, particularly [Greg Hurrell](https://github.com/wincent/winncent).

* Target platforms: macOS
* Setup method: shell script based on [Mike McQuaid's](https://github.com/MikeMcQuaid/dotfiles), plays nice with [strap](https://github.com/MikeMcQuaid/strap).

## Usage

Run [`script/setup`](script/setup) after checkout.

This will symlink everything in this directory to your home directory.

## Features

Characteristics include:

* Sane Vim pasting via bracketed paste mode.
* Write access to local clipboard from local and remote hosts, inside and outside of tmux (via [Clipper](https://github.com/wincent/clipper)).
* Full mouse support (pane/split resizing, scrolling, text selection) in Vim and tmux.
* Focus/lost events for Vim inside tmux.
* Cursor shape toggles on entering Vim.
* Italics in the terminal.
* Conservative Vim configuration (very few overrides of core functionality; most changes are unobtrusive enhancements; some additional functionality exposed via `<Leader>` and `<LocalLeader>` mappings.
* Relatively restrained Zsh config

Prompt is a minimal fork of [Pure](https://github.com/sindresohrus/pure).

Convenient Zsh features/functions include:

- `Ctrl-t` [fzf](https://github.com/jungunn/fzf) file search
- ?? fzf + git
- ?? fasd

## Dependencies

A brief list of important dependencies, listed in full in the [`Brewfile`](brewfile):

* [Alacritty](http://github.com/jwilm/alacritty/), the fastest terminal emulator.
* [tmux](http://tmux.sourceforge.net/) 2.X or later.
* [Neovim](https://neovim.io/) 0.3 or later.
- [Zsh](http://www.zsh.org/) 5.6 or later.
- [Git](http://git-scm.com/)
* [Clipper](https://wincent.com/products/clipper) for transparent access to the local system clipboard
* Fixed-width font that includes the [Powerline glyphs](http://powerline.readthedocs.io/en/master/installation.html#fonts-installation).

## Notes

- `tmux-256color` - see https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95

## License

Unless otherwise noted, the contents of this repo are in the public domain. See the [LICENSE](LICENSE.md) for details.

## Author

This repo is maintained by James Ramsay.

With thanks to:

- [Greg Hurrell](https://github.com/wincent/wincent) for his helpful [YouTube series](https://www.youtube.com/channel/UCXPHFM88IlFn68OmLwtPmZA)
- [Mike McQuaid](https://github.com/MikeMcQuaid/dotfiles) for his tidy repo and simple setup scripts 
