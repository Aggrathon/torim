# Torim - Simple and informative Zsh theme for Zim

This is a prompt theme for [Zsh](https://www.zsh.org/) designed to be used with the [Zim framework](https://zimfw.sh).

![Terminal screenshot](screenshot.avif)

This theme is inspired by / has taken features from
- https://github.com/zimfw/sorin
- https://github.com/zimfw/asciiship
- https://github.com/ohmyzsh/ohmyzsh/wiki/themes#mh


## Features

A one-line prompt where the left side:

- Shows user and host name only when accessed via SSH
- Truncates long paths (for the working directory)
- Changes colour to indicate root privileges

And the right side shows:

- If the last command failed (and error code)
- The duration of long-running commands
- The current time
- Git status
- Any active virtual environment


## Installation

1. Install Zsh and [Zim](https://zimfw.sh)
2. Add the following lines to your `.zimrc` (you might already have the dependencies):

```
zmodule duration-info
zmodule git-info
zmodule aggrathon/torim
```
