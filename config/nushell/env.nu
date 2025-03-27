# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu

# --- Carapace autocompletions ---
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

# --- Starship propmt ---
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
