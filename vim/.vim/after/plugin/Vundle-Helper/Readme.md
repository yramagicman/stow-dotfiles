# VundleHelper
A plugin for automatically synchronizing plugins across systems
and keeping them updated.

<a
href="https://www.youtube.com/watch?v=G_5oD8t2F1Q&feature=youtu.be&t=29"><img
src="http://i.giflike.com/ZfH9dkI.gif" title="Working on not working (Click to
see on Youtube)" /></a>

**IMPORTANT**: Make sure you read the installation instructions. This plugin
isn't meant to live in your .vim/bundle folder. If you put it there, it can't
do its job when you switch computers.

## CONTENTS

1. Intro
2. Requirements
3. Usage
    - Installation
4. License
5. Known Issues

###Intro

VundleHelper is designed to allow you to forget about managing and updating
your plugins. It is designed to make porting your entire Vim configuration from
one computer to another as simple as installing git and Vim, cloning your
dotfiles and opening Vim.

VundleHelper is also self-updating, so you don't need Vundle to manage the
updates for you. When VundleHelper updates the rest of your plugins it will
automatically update itself after you close Vim. This way you don't have to
wait for vundlehelper to update along with the rest of the plugins before you
get to work.

###Requirements

- *nix
- python 2
- git
- Vundle

###Usage

Vundle helper provides two commands and several configuration options, only one
of which is required. The commands run automatically every time Vim loads, but
are avaliable to run manually if necessary. On my system, there is little
performance impairment from running these commands every time Vim loads. This
is partly due to the fact that my vimrc is modular and my plugins are all
listed in their own file. It's also due to the fact that the plugin isn't doing
very much on startup unless it has to.

**IMPORTANT:** In order for this to work, the plugin must be pulled down with
your dotfiles and sourced from .vim/after/plugin. If this plugin isn't pulled
down with your dotfiles it can't do what it's supposed to do.

###Installation:

Run the following commands:

    mkdir -p ~/.vim/after/plugin cd ~/.vim/after/plugin git submodule add
    https://github.com/yramagicman/Vundle-Helper echo "source
    ~/.vim/after/plugin/Vundle-Helper/plugin/VundleHelper.vim" > pluginsync.vim

####Commands:

- `VHUpdate`: Checks the last time your plugins were updated and runs the
  updates if they haven't been updated in a specified amount of time.

- `VHInstall`: Reads your plugin list and compares it to the plugins you have
  installed. If the lists match nothing is done, if they don't match plugins
  are added or removed to make them match.

####Options:

`g:VundleHelper_Setup_Folders`

**Required!** A list of directories that you want in your ~/.vim directory.
This option is great if you keep your backups and swaps in a centralized
location.

Example:

`let g:VundleHelper_Setup_Folders = ['autoload', 'backup', 'bundle', 'colors',
'config', 'doc', 'snippets', 'spell', 'swaps', 'syntax', 'tags', 'undo' ]`

`g:VundleHelper_Plugin_File`

If you keep your plugins listed in a separate file this is the file that you
keep your plugins in. If a file isn't specified your ~/.vimrc is used.  NOTE:
If your vimrc is rather large this will be slow. I haven't optimized this to
just read the necessary parts of the file. This file path is a string and must
begin with a "/" and is relative to the current users home directory.

Example:

`let g:VundleHelper_Plugin_File = '/.vim/config/extensions/vundle.vim'`

`g:VundleHelper_Update_Frequency`

Defaults to 30 days. This defines the number of days to wait between updating
your plugins. The information regarding the last update is stored in
~/.vim/lastupdate as two unix time stamps.

Example:

`g:VundleHelper_Update_Frequency=15`

### License

If you make improvements, I'd like them back, but that's not required. Other
than that, this is yours to do with as you please. The only thing I require is
that you don't remove the copyright notice.

## Known issues

1. Plugins that don't have a forward slash ("/") in the string aren't
recognized.

2. Currently this plugin can't be installed via Vundle and work the way it's
designed to work. I intend to write an install function that enables this, but
currently I don't know of a good way to do this. Ideally I'd use a git
post-checkout hook to hard link the files into the right location, but I don't
know how to implement that. I'll probably end up implementing something in
python.

3. Doesn't work on Windows, and I have no plans of porting to Windows. I use os
level commands to get directory contents and work with the file system because
that is what I know. I could re-write the same functionality purely in python,
but I'm fairly sure that os level commands are more reliable and probably
faster. I'm certain that os level commands are easier to write.

Copyright Jonathan Gilson 2014
