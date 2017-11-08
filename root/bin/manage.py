#!/usr/bin/env python3
import os
import sys
import subprocess

needle = 'manage.py'
try:
    env = os.getenv('PROJECT_ROOT')
    proj_root = env
    for root, dirs, files in (os.walk(env)):
        if needle in files:
            print(root, files[files.index(needle)])
            subprocess.call([root.strip() + '/' + files[files.index(needle)]] + sys.argv[1:])
except KeyboardInterrupt:
    exit()
