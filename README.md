# vim-config

Personal Vim setup for Windows, macOS, and Linux. Bundles:

- [vim-plug](https://github.com/junegunn/vim-plug) - plugin manager
- [fzf](https://github.com/junegunn/fzf) + [fzf.vim](https://github.com/junegunn/fzf.vim) - fuzzy finder
- [NERDTree](https://github.com/preservim/nerdtree) - file explorer (auto-opens at startup)
- [coc.nvim](https://github.com/neoclide/coc.nvim) - LSP / completion engine
- [papercolor-theme](https://github.com/NLKNguyen/papercolor-theme) - color scheme
- [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) - live Markdown preview in the browser

Language Server is configured with local binaries and extensions:
- binaries: Go (gopls) and Python (pyrefly)
- extensions: coc-json, coc-tsserver


## 1. Required tools

Install these before copying any config.

| Tool      | Why                              |
|-----------|----------------------------------|
| Vim 8.1+  | The editor  |
| Node.js   | Required by coc.nvim |
| fzf       | Fuzzy finder binary              |
| ripgrep   | Backs `:Rg` in fzf.vim (content search) |
| find      | Backs `:Files` in fzf.vim (file listing) |
| gopls     | Go LSP (optional) |
| pyrefly   | Python LSP (optional) |

### Windows (PowerShell)

```powershell
winget install Git.Git Vim.Vim junegunn.fzf BurntSushi.ripgrep.MSVC GnuWin32.FindUtils
```

### macOS (Homebrew)

```sh
brew install vim git fzf ripgrep findutils
$(brew --prefix)/opt/fzf/install --all
```


### Language servers (optional, only what you use)

- [gopls](https://go.dev/gopls/)
- [pyrefly](https://pyrefly.org/en/docs/installation/)


## 2. Copy config files into place

| File in this repo                       | Destination                              |
|-----------------------------------------|------------------------------------------|
| `.vimrc`                                | `~/.vimrc`                               |
| `.vim/coc-settings.json`                | `~/.vim/coc-settings.json`               |
| `.config/coc/extensions/package.json`   | `~/.config/coc/extensions/package.json`  |

Note: the `.vimrc` sets `g:coc_config_home = '~/.vim'`, so `coc-settings.json`
must live under `~/.vim/`, not the coc default path.

### Windows (PowerShell)

```powershell
git clone https://github.com/<you>/vim-config.git $HOME\vim-config
cd $HOME\vim-config

Copy-Item .vimrc $HOME\.vimrc -Force
New-Item -ItemType Directory -Force $HOME\.vim, $HOME\.config\coc\extensions | Out-Null
Copy-Item .vim\coc-settings.json $HOME\.vim\coc-settings.json -Force
Copy-Item .config\coc\extensions\package.json $HOME\.config\coc\extensions\package.json -Force
```

### macOS / Linux

```sh
git clone https://github.com/<you>/vim-config.git ~/vim-config
cd ~/vim-config

cp .vimrc ~/.vimrc
mkdir -p ~/.vim ~/.config/coc/extensions
cp .vim/coc-settings.json ~/.vim/coc-settings.json
cp .config/coc/extensions/package.json ~/.config/coc/extensions/package.json
```


## 3. Install vim-plug

### Windows (PowerShell)

```powershell
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
  New-Item $HOME\.vim\autoload\plug.vim -Force
```

### macOS / Linux

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs `
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```


## 4. Install plugins

Open Vim and run:

```vim
:PlugInstall
```

This pulls fzf, NERDTree, coc.nvim, papercolor-theme, and markdown-preview.nvim.
The markdown-preview entry has a build hook (`cd app && npx --yes yarn install`)
that compiles its frontend; let it finish before moving on.

If markdown-preview was installed before this hook existed, force the build
hook to run:


```powershell
cd $HOME\.vim\plugged\markdown-preview.nvim\app
npx --yes yarn install
```


## 5. Install coc extensions

Inside Vim:

```vim
:CocInstall coc-json coc-tsserver
```

Verify LSPs are live:

```vim
:CocInfo
:CocList services
```


## 6. Key mappings

Leader is the default `\`.

| Mode    | Keys           | Action                              |
|---------|----------------|-------------------------------------|
| Normal  | `gd`           | Go to definition (coc)              |
| Normal  | `gy`           | Go to type definition (coc)         |
| Normal  | `gi`           | Go to implementation (coc)          |
| Normal  | `gr`           | Find references (coc)               |
| Normal  | `<leader>cf`   | Copy current filename to clipboard  |
| Normal  | `<leader>cp`   | Copy current full path to clipboard |
| Command | `:MarkdownPreview` | Open current .md in browser     |
| Command | `:NERDTree`    | Toggle file tree (auto-opens at start) |


## 7. Troubleshooting

- **`:CocInfo` shows gopls / pyrefly missing** - install the LSP binary, then
  restart Vim.
- **`:MarkdownPreview` fails or shows only a node version line** - the build
  hook did not run. Empty `app/node_modules` is the giveaway:
  ```powershell
  ls $HOME\.vim\plugged\markdown-preview.nvim\app\node_modules
  ```
- **Clipboard does not work** - on Linux you need Vim built with `+clipboard`
  (e.g. `vim-gtk3`). The `.vimrc` uses `unnamedplus` on Windows and `unnamed`
  elsewhere.
- **fzf not found on Linux** - the `.vimrc` adds `/usr/share/fzf` to
  runtimepath. If your distro installs fzf elsewhere, edit that path or
  `apt install fzf`.
