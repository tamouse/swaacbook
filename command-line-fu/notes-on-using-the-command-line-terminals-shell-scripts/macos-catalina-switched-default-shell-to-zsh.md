---
description: 'zsh has been available, now it''s the default. I guess it''s time.'
---

# MacOS Catalina switched default shell to zsh

A collection of things I've found, hopefully helpful in switching.

### Links

* [Use zsh as the default shell on your Mac](https://support.apple.com/en-us/HT208050) - article from apple support
* [Moving to zsh](https://scriptingosx.com/2019/06/moving-to-zsh/) - 7 part series on making the move
* [Official zsh docs](http://zsh.sourceforge.net/Doc/Release/index.html)

### Completion

Completion is quite different between bash and zsh, and was the primary reason that I switched back to bash when I first tried zsh, since my hands and fingers were wired up differently and I just could not figure out zsh at that point.

Here are some more links on completion that might help me

* zsh-users [zsh-completion-howto](https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org) \(on Github\)
* zsh-users [zsh Completion Guide](https://github.com/zsh-users/zsh/blob/master/Etc/completion-style-guide)
* [Official zsh doc completion section](http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Completion-System)
* [a macOS-specific set of completions](https://github.com/scriptingosx/mac-zsh-completions)

### oh my zsh!

The _sine qua non_ of utilities for zsh

* [pretty web site](https://ohmyz.sh/)
* [github repo](https://github.com/robbyrussell/oh-my-zsh/)

### options

pilfered from "Moving to zsh" article above

#### case-insensitive globbing

The zsh option which controls this is CASEGLOB. Since we want globbing to be case-insensitive, we want to turn the option off, so:

```text
setopt NO_CASE_GLOB
```

#### tab completion

In zsh tab completion will replace the wildcard with the actual result.

```text
% ls ~/d*<tab>
```

So after the tab you will see:

```text
% ls /Users/armin/Desktop /Users/armin/Documents /Users/armin/Downloads
```

Using tab completion this way to see and possibly edit the actual replacement for wildcards is a useful safety net.

In bash, pressing the tab key **twice** will list possible completions, but not substitute them in the command prompt.

If you do not like this behavior in zsh then you can change to behavior similar to bash with:

```text
setopt GLOB_COMPLETE
```

#### saving history when shell exits

By default, zsh does not save its history when the shell exits. The history is ‘forgotten’ when you close a Terminal window or tab. To make zsh save its history to a file when it exits, you need to set a variable in the shell:

```text
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
```

#### using a single history file for all shells

You can tell zsh to use a single, shared history file across the sessions and append to it rather than overwrite:

share history across multiple zsh sessions

```text
setopt SHARE_HISTORY
```

append to history

```text
setopt APPEND_HISTORY
```

#### write to history file after avery command

Furthermore, you can tell zsh to update the history file after every command, rather than waiting for the shell to exit:

add commands as they are typed, not at shell exit

```text
setopt INC_APPEND_HISTORY
```

#### removing some things from history file

When you use a shared history file, it will grow very quickly, and you may want to use some options to clean out duplicates and blanks:

expire duplicates first:

```text
setopt HIST_EXPIRE_DUPS_FIRST
```

do not store duplications

```text
setopt HIST_IGNORE_DUPS
```

ignore duplicates when searching

```text
setopt HIST_FIND_NO_DUPS
```

remove blank lines from history

```text
setopt HIST_REDUCE_BLANKS
```

