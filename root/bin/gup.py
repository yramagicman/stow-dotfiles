#!/usr/bin/env python
import os
import subprocess
import sys
import time


class gup:
    """ updates git stuff, hopefully in parallel"""

    def __init__(self):
        """ set up repos and commands"""
        self.home = os.path.expanduser('~')
        home = self.home
        configfile = open(home + '/.config/gits')
        self.repos = [l.strip() for l in configfile.readlines() if l[0] != '#']
        self.repos.append(os.getcwd())
        # arrays used in subprocess.call and such
        self.pull = ['git', 'pull', '--rebase']
        self.fetch = ['git', 'fetch']
        self.push = ['git', 'push']
        self.ppull = ['pass', 'git', 'pull']
        self.ppush = ['pass', 'git', 'push']
        self.checkout = ['git', 'checkout', '-q', 'master']
        self.zupdate = [self.home + '/bin/zupdate']
        self.local_status = ['git', 'rev-parse', '@']
        self.remote_status = ['git', 'rev-parse', '@{u}']
        self.merge_base = ['git', 'merge-base', '@', '@{u}']

    def num_changes(self):
        """ Gets the number of changes to a git repo"""
        git = subprocess.Popen(['git', 'status'], stdout=subprocess.PIPE)
        grep = subprocess.Popen(
            ['grep', 'modified'], stdin=git.stdout, stdout=subprocess.PIPE)
        wc = subprocess.Popen(
            ['wc', '-l'], stdin=grep.stdout, stdout=subprocess.PIPE)
        git.stdout.close()
        grep.stdout.close()
        output, err = wc.communicate()
        output = output.strip()
        if not err:
            return output

    def diff_changes(self, ext=False):
        """ Lists changes to a git repo """
        if ext:
            git = subprocess.Popen(['git', 'diff'])
            output = git.communicate()
            return
        git = subprocess.Popen(['git', 'diff', '--no-ext-diff'])
        output = git.communicate()
        return output

    def list_changes(self):
        """ Lists changes to a git repo """
        git = subprocess.Popen(['git', 'status'], stdout=subprocess.PIPE)
        grep = subprocess.Popen(
            ['grep', 'modified'], stdin=git.stdout, stdout=subprocess.PIPE)
        git.stdout.close()
        output, err = grep.communicate()
        output = output.strip()
        if not err:
            return output

    def check_status(self):
        """ Supposed to see whose ahead and whose behind"""
        subprocess.call(self.checkout)
        c_local = subprocess.check_output(self.local_status)
        c_remote = subprocess.check_output(self.remote_status)
        c_merge = subprocess.check_output(self.merge_base)
        if c_local == c_remote:
            # ok
            return 0
        elif c_local == c_merge:
            # pull
            return -1
        elif c_remote == c_merge:
            # push
            return 1
        else:
            # notihing's equal
            return 2

    def pull_push(self, pull, push):
        """ Actually does the work """
        # apparently I have to fetch before I can do anything
        subprocess.call(self.fetch)
        stat = self.check_status()
        dir = os.getcwd().replace(self.home, '~')
        if stat != 0:
            if stat == -1:
                print('\n' + dir + '\n' + str(subprocess.call(pull)))
            elif stat == 1:
                print('\n' + dir + '\n' + str(subprocess.call(push)))
            else:
                # since nothings equal we'll diff it.
                subprocess.call(['git', 'diff', 'HEAD', 'master',
                                 'origin/HEAD', 'origin/master'])
        else:
            print(self.show_message())

    def show_message(self):
        """ returns the message displayed to the user"""
        changes = self.num_changes()
        dir = os.getcwd().replace(self.home, '~')
        if int(changes) == 1:
            singular = ['\n', dir, 'is up to date with',
                        str(changes), 'change unstaged. \n\t']
            message = ' '.join(singular)
        else:
            if int(changes) > 0:
                plural = ['\n', dir, ' is up to date with ',
                          str(changes), ' unstaged changes.\n\t']
                message = ' '.join(plural)
            else:
                up_to_date = ['\n', dir, 'is up to date with',
                              str(changes), 'unstaged changes.']
                message = ' '.join(up_to_date)
        message = ' '.join([str(message), str(self.list_changes())])
        if '--diff' in sys.argv or '-d' in sys.argv:
            if '--ext' in sys.argv or '-e' in sys.argv:
                self.diff_changes(True)
                return message  # end external diff
            self.diff_changes()
            return message  # end internal diff
        return message  # end function

    def do_it(self, repo):
        """ wrapper function, checks current working directory and does the
        right thing based on that """
        os.chdir(repo)
        pwd = os.getcwd()
        if pwd != self.home + '/.zprezto' and '/.password-store' not in pwd:
            self.pull_push(self.pull, self.push)
        if pwd[pwd.rindex('/'):] == '/.zprezto':
            subprocess.call(self.zupdate)
            self.pull_push(self.pull, self.push)
        if '/.password-store' in pwd:
            self.pull_push(self.ppull, self.ppush)
        if time.localtime()[2] < 7:
            subprocess.call(['git', 'gc'])
        return 1

    def run(self):
        """ simplify calling stuff"""
        repos = self.repos
        for repo in repos:
            self.do_it(repo)
            # p = multiprocessing.Process(target=gup().do_it, args=(repo,))
            # p.start()
            # p.join()
if __name__ == '__main__':
    g = gup()
    g.run()
