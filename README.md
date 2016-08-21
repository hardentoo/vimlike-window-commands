# vimlike-window-commands

A window specific vimlike commands for linux.   Commands can be aliased and all bash syntax (piping, redirection...) and commands (sed, grep...) can be used.

---

###Installation
- Clone all of the dotfiles into your home user directory and make all sh scripts executable.

- Bind `commands.sh` to a key

###Configuration
- Aliases are defined in the file `~/.xcmds`.

- Aliases are created in input script by order of specificity from the bottom to top of the file under appropriate headers.

- The headers are the names of focused windows at the invocation of commands.sh.  Use the syntax `alias INVOCATION COMMAND` to define aliases under appropriate header.  An alias under unspecified header is expanded for all windows with the least specificity.

- Comments are delimited between a # and carriage return.

- `$WINI` is the environment variable for `xdotool getwindowfocus` within config file prior to invocation of `commands.sh`.

- `$WIN` is the environment variable for the name of the focused window prior to invocation of `commands.sh`.

- `$TXT` is environment variable for command.  Can be used to create quines.
