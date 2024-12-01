# Some information

I sometimes use Java for my development and making applications. Here I collected any information which you can use for changing current NeoVim for java development configuration.

Use this file as the FAQ. If you can't find your question, make free to open issue with appropriate question.

## I want to use only one version JDK

Firstly, please edit a file `path/to/dotfiles/config/nvim/ftplugin/java.lua` at the line 221 to:

```lua
configuration = {
    runtimes = {
        {
            name = "JavaSE-{your java version}"
            path = os.getenv("JAVA_HOME"), -- you can set this variable in ~/.profile or ~/.zshrc files
            default = true
        },
    },
},
```

Next, as I described above in the commentary, you must set the env variable `JAVA_HOME`, which contains path to java JDK/JRE, in `~/.profile` or `~/.zshrc`.

> __NOTE__
> You can put directly path instead of getting env variable. But I highly recommend use the env variable, because it is most easier.

## My LSP it not working

Maybe, you skipped the part, in which I described that you need to compile target file. Why is it required? Because the target file is the Java LSP. If the file doesn't exists, the LSP can't run.

Install JDK-17 version and use it to compile in directory `path/to/dotfiles/share/eclipse.jdt.ls`:

```bash
JAVA_HOME=path/to/jdk/17 ./mvnw clean verify -DskipTests=true # The tests are not necessary IMHO, you can remove last argument to enable tests.
```

> __NOTE__
> I always skip tests because it is very costly by time for me, so I want to avoid it. I know that it is sometimes very risky, maybe with memory leaking or another annoying problems.

## I have errors like java.lang.String and java.lang.String are incompatible

Maybe you use different JDK version, try another.
