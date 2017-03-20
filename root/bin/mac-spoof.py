#!/usr/bin/env python
from random import randint
import subprocess


def get_first():
    first = open('/home/jonathan/useable.txt')
    first_array = [f.strip() for f in first.readlines()]
    first.close()
    return first_array[randint(0, len(first_array) + 1)]


def make_rest():
    rest = []
    while (len(rest) < 3):
        rest.append('%02X' % (randint(0, 256)))
    return ':'.join(rest)
addr = [get_first(), make_rest()]
addr = ':'.join(addr)
print("Your new MAC address is " + addr)
subprocess.call(['ip', 'link', 'set', 'dev', 'wlp2s0', 'down'])
subprocess.call(['ip', 'link', 'set', 'dev', 'wlp2s0',
                 'address',  addr])
subprocess.call(['ip', 'link', 'set', 'dev', 'wlp2s0', 'up'])
