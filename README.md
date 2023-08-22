# About

It's dotfiles that I use in my work.

I am Java developer and this dotfiles is sharpened for this. Powerful JDKs, JDT.LS and good code editor Neovim with specific plugins for this environment.

## Preparation steps

Firsly, I shall to tell you that this dotfiles need some dependencies if you want use all potential power. I know, some dependencies for you may be not good for you. But it is my ecosystem, this is comfortable for me.

Preparation by three steps:

1. Run the shell script that checks your system by existance of binaries. It tell you if needed package is missing.

```bash
sh preparation_script.sh
```

2. Make sure installed git submodules. If is not, run the command below:

```bash
git pull --recursive-submodules
```

3. Fine-tuning. I will focus on this point in more detail.

Make sure that you have installed JDK with four versions: Java-20, Java-17, Java-11 and Java-1.8. And put it in your `.zshrc` file the environment variables by template:

```bash
export JAVA_HOME={path_to_java_17}
export JAVA_LASTEST_HOME={path_to_java_20}
export JAVA_11_HOME={path_to_java_11}
export JAVA_8_HOME={path_to_java8}
```

Also you need put this line for referencing specific zshrc file:

```bash
source {path/to}/dotfiles/config/zsh/zshrc
```

Next, you need compile the `eclipse.jdt.ls`. Make sure that your environment variable JAVA_HOME is right and go to the git submodule `eclipse.jdt.ls` that placed at `dotfiles/share/java_extensions`. Compile the project by command:

```bash
./mwnw clean verify
```

And that is all! Enjoy the code editor!

### Troubleshooting

If you have missing plugin that needed for this environment, but it is not described. Then make the issue, I will fix it and help you!

#### License

[MIT](https://github.com/jarkz/dotfiles/LICENSE)
