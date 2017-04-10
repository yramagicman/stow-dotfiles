# stow-dotfiles

I have the best dotfiles in the world, or at least I think I do, and you should
think the same thing about yours. My dotfiles are the best because they are
almost completely self installing.

## To use my dotfiles:

1. You'll need to install GNU stow and git. On Arch Linux it's as simple as
   running `sudo pacman -S stow git`.
2. Once that's installed clone my dotfiles with `git clone
   https://github.com/yramagicman/stow-dotfiles`
3. Edit `$dotfiles_dir/root/.zshrc`. While doing this you're going to want to
   change two things.
    - First, the `$CONFIG_DIR` variable. This path is automatically created when
      you run ZSH for the first time, and it's where your plugins will be
      stored.
    - Second, you'll want to edit the plugins section. The `source_or_clone`
      function takes a file path and a git repo url. The file path should be the
      local path to the `init.zsh` file for the plugin, beginning with the
      $CONFIG_DIR variable. The git repo can be any url that resolves to a git
      repository
4. Once you have those two things edited, run `$dotfiles_dir/init.sh`. This will
   run gnu stow and put everything in your home directory, or `.config`
   directory as is necessary. **A word of warning though: Any conflicting
   dotfiles in your home directory will cause this to fail.** You will have to
   back up those files and remove them in order for this to work.
5. After gnu stow finishes successfully init.sh will automatically change your
   default shell to ZSH, if it's not already ZSH.
6. Log out and back in, or open a new shell. If you have any packages configured
   to install, you will be prompted to install them. **Another word of warning:
   Do not install arbitrary plugins without reading them first, especially if
   you're going to be running commands with root access.** Read the code in the
   packages before saying yes to installing them.
7. Finally open VIM and/or Emacs. Vim will automatically download the latest
   version of vim-plug and install it, along with any packages you've configured
   beforehand. Emacs will also automatically install any packages you've
   configured in init.el.