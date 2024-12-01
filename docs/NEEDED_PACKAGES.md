# About

There is a list of packages that need to install to get working environment.
For ease I splitted them into three groups: [generic](#generic-packages),
[for desktop](#packages-for-desktop), [for NeoVim](#packages-for-neovim).

Also I've posted links for some packages to github repository for review.

> [!NOTE]
> For some packages I put their version and that means I use only this version range.
> So I don't guarantee that configurations will work fine with other versions.

## Generic Packages

- gcc/g++
- zsh
- bc
- trash-cli
- python3
- unzip
- [bat](https://github.com/sharkdp/bat) - use it instead of `cat(1)`
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- openssh
- [btop](https://github.com/aristocratos/btop)

## Packages for Desktop

WM environment:

- [Hyprland](https://github.com/hyprwm/Hyprland) (version >= 0.45.2)
- [hyprpaper](https://github.com/hyprwm/hyprpaper)
- [hypridle](https://github.com/hyprwm/hypridle)
- [hyprlock](https://github.com/hyprwm/hyprlock)
- [hyprscroller plugin](https://github.com/dawsers/hyprscroller) for Hyprland
- [xdg-desktop-portal-hyprland](https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland)

Wayland clipboard:

- wl-clipboard

Screenshoting:

- grim
- [satty](https://github.com/gabm/satty)

Video recording:

- wf-recorder
- slurp
- zenity

Notifications:

- [noti](https://github.com/noti-rs/noti)

App Launcher:

- [wofi](https://hg.sr.ht/~scoopta/wofi)

Audio:

- pulseaudio

Icons:

- Cursor: [Bibata-Modern-Classic](https://github.com/ful1e5/Bibata_Cursor)
- App Icons: [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)

## Packages for NeoVim

- [NeoVim](https://github.com/neovim/neovim) (version >= 0.10.0)
- [tree-sitter](https://github.com/tree-sitter/tree-sitter)
- nodejs (if you working with JS)
- ruby (for htmlbeautifier, and other formatters for neovim)
- go (if you working with golang)
- lldb & lldb-dap
