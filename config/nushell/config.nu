# This file is loaded after env.nu and before login.nu

$env.DOTFILES = $"($env.HOME)/dotfiles"

$env.XDG_CONFIG_HOME = $"($env.DOTFILES)/config"
$env.XDG_CACHE_HOME = $"($env.DOTFILES)/cache"
$env.XDG_DATA_HOME = $"($env.DOTFILES)/share"
$env.XDG_STATE_HOME = $"($env.DOTFILES)/state"

$env.GPG_TTY = ^tty

$env.VISUAL = "nvim"
$env.EDITOR = $"($env.VISUAL)"

$env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"

$env.config.show_banner = false
$env.config.history.max_size = 10_000
$env.config.rm.always_trash = true

$env.config.completions.algorithm = "fuzzy"
$env.config.completions.sort = "smart"

def v [ path?: path ] { if ($path != null) { nvim $path } else { nvim } }
def nv [ path?: path ] { if ($path != null) { neovide $path } else { neovide } }


alias l = ls -la
alias md = mkdir

def cat [ path: path ] { bat --theme='Catppuccin Latte' $path }

alias caban = cabal

# Theme
source "./themes/catppuccin-latte.nu"

# Commands

source "./commands/count-lines.nu"
source "./commands/yazi.nu"

# Aliases

source "./aliases/archlinux.nu"

# Completions

# --- Carapace completions ---
source ~/.cache/carapace/init.nu
# ----------------------------

source "./completions/typst/typst-completions.nu"
source "./completions/rustup/rustup-completions.nu"
source "./completions/rg/rg-completions.nu"
source "./completions/nix/nix-completions.nu"
source "./completions/man/man-completions.nu"
source "./completions/make/make-completions.nu"
source "./completions/git/git-completions.nu"
source "./completions/gh/gh-completions.nu"
source "./completions/curl/curl-completions.nu"
source "./completions/cargo-make/cargo-make-completions.nu"
source "./completions/cargo/cargo-completions.nu"
source "./completions/bat/bat-completions.nu"

# --- Starship propmt ---
use ~/.cache/starship/init.nu
# -----------------------
