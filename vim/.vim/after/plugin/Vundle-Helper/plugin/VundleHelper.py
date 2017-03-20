import os
import vim
import datetime
import time
from subprocess import call, check_output
home = os.path.expanduser('~')


def VundleHelper_sanity_check():
    """Make sure variables exist. The script only requires
    g:VundleHelper_Setup_Folders."""
    dir_tree_defined = int(vim.eval('exists("g:VundleHelper_Setup_Folders")'))
    plugin_file_defined = int(vim.eval('exists("g:VundleHelper_Plugin_File")'))
    # Check for .vim/bundle. The script breaks without it.
    if not os.path.exists(home + '/.vim/bundle'):
        cmd = ['mkdir', '-p']
        cmd = cmd + ['bundle']
        os.chdir(home + '/.vim/')
        call(cmd)
    # If both config variables are defined, return their values.
    if dir_tree_defined and plugin_file_defined:
        dir_tree = vim.eval("g:VundleHelper_Setup_Folders")
        plugin_file = vim.eval("g:VundleHelper_Plugin_File")
        return dir_tree, plugin_file
    # If g:VundleHelper_Setup_Folders is defined, return its value and the location
    # of the .vimrc file
    elif dir_tree_defined and not plugin_file_defined:
        plugin_file = vim.eval('$MYVIMRC')
        dir_tree = vim.eval("g:VundleHelper_Setup_Folders")
        return dir_tree, plugin_file
    # When all else fails print an error message.
    else:
        print 'You must at least define g:VundleHelper_Setup_Folders for this to work.'

# Set variables globally
setup_folders, plugin_file = VundleHelper_sanity_check()


def VundleHelper_pkg_manager_install():
    """ Install Vundle. """
    os.chdir(home + '/.vim/bundle')
    call(['git', 'clone', 'https://github.com/gmarik/Vundle.vim.git'])


def VundleHelper_check_dir():
    """ List output of bundle directory. """
    installed_packages = check_output(['ls', home + '/.vim/bundle'])
    installed_packages = installed_packages.split('\n')
    return installed_packages


def VundleHelper_read_bundle(file):
    """ Read list of bundles out of file. """
    bundles = open(file, 'r')
    lines = bundles.read().split('\n')
    ret_val = []
    for line in lines:
        line.strip()
        if ('Plugin' in line or 'plugin' in line) and ('"' not in line):
            try:
                ret_val.append(line[line.index('/') + 1: -1])
            except:
                ret_val.append(line[line.index('\'') + 1: -1])
    bundles.close()
    return ret_val


def VundleHelper_check_installation():
    """ Read list of files and plugins and determine what's not installed. """
    to_install = VundleHelper_read_bundle(home + plugin_file)
    installed = VundleHelper_check_dir()
    not_installed = []
    for i in to_install:
        if i not in installed:
            not_installed.append(i)
    return not_installed


def VundleHelper_clean_up():
    """
    Read list and files and plugins and determine what needs to be removed.
    """
    listed = VundleHelper_read_bundle(home + plugin_file)
    remove = VundleHelper_check_dir()
    to_remove = []
    for i in remove:
        if i not in listed:
            to_remove.append(i)
    return to_remove


def VundleHelper_run_install():
    """ Install packages """
    if len(VundleHelper_check_installation()) > 0:
        os.chdir(home + '/.vim/')
        call(['mkdir', '-p'] + setup_folders)
        if 'Vundle.vim' in VundleHelper_check_installation():
            VundleHelper_pkg_manager_install()
            # Source .vimrc to make sure the package manager is loaded
            vim.command('source $MYVIMRC')
        # Run the package manger
        vim.command('PluginInstall')
        # Load everything.
        vim.command('source $MYVIMRC')
    # clean_up() always returns an empty string, so check for length greater
    # than 1 to account for this.
    if len(VundleHelper_clean_up()) > 1:
        vim.command('PluginClean')


def VundleHelper_update_how_often():
    """ Get interval between updates. """
    often_set = int(vim.eval('exists("g:VundleHelper_Update_Frequency")'))
    if often_set:
        return int(vim.eval('g:VundleHelper_Update_Frequency'))
    else:
        return 30


def VundleHelper_read_update_cache():
    """ Read cached times into memory. """
    try:
        f = open(home + '/.vim/lastupdate', 'r')
        dates = f.read()
        f.close()
        return dates.split('\n')
    except:
        print "Update cache not found. Running updates and writing new file."
        return VundleHelper_write_last_update()


def VundleHelper_get_last_update(dates):
    """ Get date of last update. """
    date = float(dates[0])
    return date


def VundleHelper_get_next_update(dates):
    """ Get date of next update. """
    date = float(dates[1])
    return date


def VundleHelper_write_last_update(days=30, flag=True):
    """ Write update info to file. """
    next = days * 24 * 60 * 60
    f = open(home + '/.vim/lastupdate', 'w')
    f.write(str(time.time()) + '\n')
    f.write(str(time.time() + next) + '\n')
    if flag:
        f.write('true')
    else:
        f.write('false')
    f.close()
    return str(time.time()) + '\n' + str(time.time() + next)


def VundleHelper_run_updates():
    """ Run plugin updates. """
    dates = VundleHelper_read_update_cache()
    next = VundleHelper_get_next_update(dates)
    freq = VundleHelper_update_how_often()
    if float(time.time()) > float(next):
        vim.command('PluginUpdate')
        VundleHelper_write_last_update(freq)


def VundleHelper_update_notify_check():
    """ Run plugin updates. """
    dates = VundleHelper_read_update_cache()
    next = VundleHelper_get_next_update(dates)
    if float(time.time()) > float(next):
        vim.command('let g:VundleHelperUpdateNotify=1')


def VundleHelper_self_update():
    """ Update VundleHelper. """
    dates = VundleHelper_read_update_cache()
    next = VundleHelper_get_last_update(dates)
    freq = VundleHelper_update_how_often()
    # dates[2] is a string representation of a boolean value that determines
    # when to update VundleHelper.
    if dates[2] == 'true':
        VundleHelper_git_opperation()
        VundleHelper_write_last_update(freq, False)


def VundleHelper_git_opperation():
    """ Git functions to update VundleHelper. """
    repo = home + '/.vim/after/plugin/Vundle-Helper'
    # arrays used in subprocess.call and such
    fetch = ['git', 'fetch', '--all']
    merge = ['git', 'reset', '--hard', 'origin/master']
    print 'running update' + '\n'
    os.chdir(repo)
    print str(call(fetch)) + '\n'
    print str(call(merge)) + '\n'

# Copyright Jonathan Gilson 2014
