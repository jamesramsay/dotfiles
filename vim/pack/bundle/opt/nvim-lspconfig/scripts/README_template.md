# nvim-lsp

Collection of common configurations for the [Nvim LSP client](https://neovim.io/doc/user/lsp.html).

**Note:** `nvim-lsp` is unrelated to [vim-lsp](https://github.com/prabirshrestha/vim-lsp).

It is hoped that these configurations serve as a "source of truth", but they
are strictly _best effort_. If something doesn't work, these configs are useful
as a starting point, which you can adjust to fit your environment.

This is work-in-progress and **requires [Nvim HEAD/nightly](https://github.com/neovim/neovim/releases/tag/nightly)**.
Update Nvim and nvim-lsp before reporting an issue.

## Contributions are welcome!

There are many language servers in the world, and not enough time.
Help us create configs for *all the LSPs!*

1. Read [CONTRIBUTING.md](CONTRIBUTING.md) for instructions.
   Ask questions in [Neovim Gitter](https://gitter.im/neovim/neovim).
2. Choose a language from [the coc.nvim wiki](https://github.com/neoclide/coc.nvim/wiki/Language-servers) or
  [the emacs-lsp project](https://github.com/emacs-lsp/lsp-mode#supported-languages).
3. Create a new file at `lua/nvim_lsp/SERVER_NAME.lua`. See
   [existing configs](https://github.com/neovim/nvim-lsp/blob/master/lua/nvim_lsp/) for
   examples (`lua/nvim_lsp/texlab.lua` is an extensive example).

## Install

- Requires [Nvim HEAD/nightly](https://github.com/neovim/neovim/releases/tag/nightly) (v0.5 prerelease).
- nvim-lsp is just a plugin. Install it like any other Vim plugin.

  e.g. [vim-plug](https://github.com/junegunn/vim-plug)
  ```
  :Plug 'neovim/nvim-lsp'
  ```
- Call `:packadd nvim-lsp` in your vimrc if you installed nvim-lsp to
  `'packpath'` or if you use a package manager such as minpac.

## Usage

Each config provides a `setup()` function, to initialize the server with
reasonable defaults and some server-specific things like commands or different
diagnostics.

```lua
vim.cmd('packadd nvim-lsp')  -- If installed as a Vim "package".
require'nvim_lsp'.<config>.setup{name=…, settings = {…}, …}
```

If you want to add this to your vimrc, you will need to enclose it in a `lua` block.

```vim
lua <<EOF
vim.cmd('packadd nvim-lsp')  -- If installed as a Vim "package".
require'nvim_lsp'.<config>.setup{name=…, settings = {…}, …}
EOF
```

Find the [config](#configurations) for your language, then paste the example
given there to your `init.vim`. **All examples are given in Lua,** see `:help
:lua-heredoc` to use Lua from your init.vim.

Some configs may define additional server-specific functions, e.g. the `texlab`
config provides `nvim_lsp.texlab.buf_build({bufnr})`.

### Example: using the defaults

To use the defaults, just call `setup()` with an empty `config` parameter.
For the `gopls` config, that would be:

```lua
vim.cmd('packadd nvim-lsp')  -- If installed as a Vim "package".
require'nvim_lsp'.gopls.setup{}
```

### Example: override some defaults

To set some config properties at `setup()`, specify their keys. For example to
change how the "project root" is found, set the `root_dir` key:

```lua
local nvim_lsp = require'nvim_lsp'
nvim_lsp.gopls.setup{
  root_dir = nvim_lsp.util.root_pattern('.git');
}
```

The [documentation](#configurations) for each config lists default values and
additional optional properties.

```lua
local nvim_lsp = require'nvim_lsp'
nvim_lsp.texlab.setup{
  name = 'texlab_fancy';
  log_level = vim.lsp.protocol.MessageType.Log;
  message_level = vim.lsp.protocol.MessageType.Log;
  settings = {
    latex = {
      build = {
        onSave = true;
      }
    }
  }
}
```

### Example: custom config

To configure a custom/private server, just require `nvim_lsp/configs` and do
the same as we do if we were adding it to the repository itself.

1. Define the config: `configs.foo_lsp = { … }`
2. Call `setup()`: `require'nvim_lsp'.foo_lsp.setup{}`

```lua
local nvim_lsp = require'nvim_lsp'
local configs = require'nvim_lsp/configs'
-- Check if it's already defined for when I reload this file.
if not nvim_lsp.foo_lsp then
  configs.foo_lsp = {
    default_config = {
      cmd = {'/home/ashkan/works/3rd/lua-language-server/run.sh'};
      filetypes = {'lua'};
      root_dir = function(fname)
        return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      settings = {};
    };
  }
end
nvim_lsp.foo_lsp.setup{}
```

### Example: override default config

If you want to change default configs for all servers, you can override default_config like this.

```lua
local nvim_lsp = require'nvim_lsp'
nvim_lsp.util.default_config = vim.tbl_extend(
  "force",
  nvim_lsp.util.default_config,
  { log_level = lsp.protocol.MessageType.Warning.Error }
)
```

### Installing a language server

Configs may provide an `install()` function. Then you can use
`:LspInstall {name}` to install the required language server.
For example, to install the Elm language server:

    :LspInstall elmls

Use `:LspInstallInfo` to see install info.

    :LspInstallInfo

## setup() function

The `setup()` interface:

```
nvim_lsp.SERVER.setup{config}

  The `config` parameter has the same shape as that of
  |vim.lsp.start_client()|, with these additions and changes:

  {root_dir}
    Required for some servers, optional for others.
    Function of the form `function(filename, bufnr)`.
    Called on new candidate buffers being attached-to.
    Returns either a root_dir or nil.

    If a root_dir is returned, then this file will also be attached. You
    can optionally use {filetype} to help pre-filter by filetype.

    If a root_dir is returned which is unique from any previously returned
    root_dir, a new server will be spawned with that root_dir.

    If nil is returned, the buffer is skipped.

    See |nvim_lsp.util.search_ancestors()| and the functions which use it:
    - |nvim_lsp.util.root_pattern(patterns...)| finds an ancestor which
    - contains one of the files in `patterns...`. This is equivalent
      to coc.nvim's "rootPatterns"
    - Related utilities for common tools:
      - |nvim_lsp.util.find_git_root()|
      - |nvim_lsp.util.find_node_modules_root()|
      - |nvim_lsp.util.find_package_json_root()|

  {name}
    Defaults to the server's name.

  {filetypes}
    Set of filetypes to filter for consideration by {root_dir}.
    May be empty.
    Server may specify a default value.

  {log_level}
    controls the level of logs to show from window/logMessage notifications. Defaults to
    vim.lsp.protocol.MessageType.Warning instead of
    vim.lsp.protocol.MessageType.Log.

  {message_level}
    controls the level of messages to show from window/showMessage notifications. Defaults to
    vim.lsp.protocol.MessageType.Warning instead of
    vim.lsp.protocol.MessageType.Log.

  {settings}
    Map with case-sensitive keys corresponding to `workspace/configuration`
    event responses.
    We also notify the server *once* on `initialize` with
    `workspace/didChangeConfiguration`.
    If you change the settings later on, you must emit the notification
    with `client.workspace_did_change_configuration({settings})`
    Example: `settings = { keyName = { subKey = 1 } }`

  {on_attach}
    `function(client)` executed with the current buffer as the one the {client}
    is being attached-to. This is different from
    |vim.lsp.start_client()|'s on_attach parameter, which passes the {bufnr} as
    the second parameter instead. Useful for doing buffer-local setup.

  {on_new_config}
    `function(new_config)` will be executed after a new configuration has been
    created as a result of {root_dir} returning a unique value. You can use this
    as an opportunity to further modify the new_config or use it before it is
    sent to |vim.lsp.start_client()|.
```

# Configurations

The following LSP configs are included. Follow a link to find documentation for
that config.

{{implemented_servers_list}}

{{lsp_server_details}}
