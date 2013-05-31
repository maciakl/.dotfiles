My Dotfiles
===========

Various dot files other than .vim which I maintain separately. These are my config files for tmux, mc, pine and etc...

Instructions
---

Clone this repo to your `~`. Once done, run:

    ~/.dotfiles/bootstrap

This will move all relevant dotfiles to `~/backup_dotfiles` and will then create symlinks in your home directory. If you had `.bashrc` in `~` already it will not be replaced. Instead the `~/.dotfiles/.bashrc` will be sourced on the first line of your original `.bashrc`. If you want it replaced and linked instead of sourced, then just delete or rename your original `.bashrc` prior to running the bootstrap script.

For git config - put private stuff (such as email, github information, etc..) in `~.gitconfig.local` and it will be appended to your `.gitconfig`.
