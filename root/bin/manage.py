#!/usr/bin/env python
import os
import sys
import subprocess

try:
    env = os.getenv('VIRTUAL_ENV')
    if '.virtualenvs' in env:
        with open(env + '/.project') as f:
            proj_root = f.readline()
            print(proj_root.strip() + '/manage.py')
            subprocess.call([proj_root.strip() + '/manage.py'] + sys.argv[1:])
            f.close()
    else:
        proj_root = env
        print(proj_root.strip() + '/manage.py')
        subprocess.call([proj_root.strip() + '/manage.py'] + sys.argv[1:])
except KeyboardInterrupt:
    exit()
