This role manages `TERMINFO` files that add escape sequences for italic,
and overwrite conflicting sequences for standout text.

To check that the terminal does the right thing:

```sh
echo `tput sitm`italics`tput ritm` `tput smso`standout`tput rmso`
```

## Acknowledgements

- [wincent](https://github.com/wincent/wincent)
  - https://www.youtube.com/watch?v=n1cKtZfwOgQ
  - https://github.com/wincent/wincent/blob/master/roles/terminfo/README.md

