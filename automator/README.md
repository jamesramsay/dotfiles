# Automator Workflows

## Screenshot compression

See [Automatic screenshot compression](https://jramsay.com.au/2020/03/29/automatic-screenshot-compression/)

1. Install dependencies

   ```shell
   brew install pngquant zopfli
   ```

1. Create a dedicated screenshot directory

   ```shell
   mkdir -p "$HOME/Screenshots"
   defaults write com.apple.screencapture location "$HOME/Screenshots/"

   killall SystemUIServer
   ```

1. Open `Screenshots.workflow` to install.
   ([Download](https://downgit.github.io/#/home?url=https://github.com/jamesramsay/dotfiles/tree/main/automator/Screenshots.workflow))
