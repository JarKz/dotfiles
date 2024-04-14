# About

The dotfiles, that I use everywhere when possible. It contain necessary and non-necessary files, which depends on situations. I store here many configs as possible.

You can remove some directories or files as you want.

## Preparation steps

Here is no installation script, so you must do all things manually. I don't want to add this script only because I want that you know, what you need to use.

But, I left here the other file named `NEEDED_PACKAGES.md`. You can read a content of this file through for understanding what I used to my ecosystem.

Please, hold in head that the most packages are used for NeoVim.

1. Install needed packages, that listed in the file above.
2. Pull each git submodule: `config/oh-my-zsh`, `share/java_extensions/eclipse.jdt.ls` (optional), `java_extensions/java-debug` (optional), `java_extensions/vscode-java-test` (optional).

> __NOTE__
> Three last submodules only java development, so you can skip they, if don't use.

For `share/java_extensions/eclipse.jdt.ls`, you need compile target file. Please, read instructions for it at [the site](https://github.com/eclipse-jdtls/eclipse.jdt.ls). See [`ABOUT_JAVA.md`](./ABOUT_JAVA.md) for additional information.

3. Setting env variables.

To avoid strange behaviors, create file `.profile` at the `$HOME` directory with these variables:

```bash
export XDG_CONFIG_HOME=path/to/dotfiles/config
export XDG_DATA_HOME=path/to/dotfiles/share
```

4. Next, create file `.zshrc` with single line:

```bash
source path/to/dotfiles/config/zsh/zshrc
```

> __NOTE__
> That is why the git submodule `config/oh-my-zsh` is required.

5. Make symbolic links to specific config files:

```bash
ln -s ~/path/to/dotfiles/config/icons ~/.icons
ln -s ~/path/to/dotfiles/config/dunst ~/.config/dunst
```

> __NOTE__
> Maybe, you need to create ~/.config directory before run second command.

Why you must do it? Only beacuse some application doesn't read `$XDG_CONFIG_HOME` environment variable that sounds very sad and incomfortable. Please to have patience with this information.

6. (OPTIONAL) Only for java devs. You must create specific environment variables according to neovim java-lsp config:

```bash
export JAVA_HOME=path/to/jdk17
export JAVA_8_HOME=path/to/jdk8
export JAVA_11_HOME=path/to/jdk11
export JAVA_LATEST_HOME=path/to/jdk21
```

In `~/.zshrc` or `.profile` file.

> __NOTE__
> I'm not using java 22 or higher because it doesn't have any sense to use. 
> You can modify this configuration, please read `ABOUT_JAVA.md`.

## Troubleshooting

If you figured out that this dotfiles requires missing package or environment variables, please open an issue or make PR with needed changes.

## Contribution

I'm open to apporopriate changes that makes this dotfiles more better.

## License

[MIT](./LICENSE)
