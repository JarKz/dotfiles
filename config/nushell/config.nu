# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.DOTFILES = $"($env.HOME)/dotfiles"

$env.XDG_CONFIG_HOME = $"($env.DOTFILES)/config"
$env.XDG_CACHE_HOME = $"($env.DOTFILES)/cache"
$env.XDG_DATA_HOME = $"($env.DOTFILES)/share"
$env.XDG_STATE_HOME = $"($env.DOTFILES)/state"

$env.GPG_TTY = ^tty

$env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"

$env.config.history.max_size = 10_000
$env.config.rm.always_trash = true

alias v = nvim
alias l = ls -la
alias md = mkdir

alias caban = cabal

def count-lines [lookup_path: path]: nothing -> int {
  glob ($"($lookup_path)/*" | path expand)
    | each {|in| if ($in | path type) == "dir" { 
        count-lines $in
      } else {
        # It doesn't work correctly with binary files like image
        try { open $in --raw | decode utf-8 | lines -s | length } catch { 0 }
    }} 
    | append 0 # For case if the input is empty
    | math sum
}

source "./themes/catppuccin-latte.nu"

# Completions

source "completions/typst/typst-completions.nu"
source "completions/rustup/rustup-completions.nu"
source "completions/rg/rg-completions.nu"
source "completions/nix/nix-completions.nu"
source "completions/man/man-completions.nu"
source "completions/make/make-completions.nu"
source "completions/git/git-completions.nu"
source "completions/gh/gh-completions.nu"
source "completions/curl/curl-completions.nu"
source "completions/cargo-make/cargo-make-completions.nu"
source "completions/cargo/cargo-completions.nu"
source "completions/bat/bat-completions.nu"
