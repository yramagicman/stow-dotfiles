import subprocess

hostname = subprocess.run(['hostname'], check=True,
                          stdout=subprocess.PIPE).stdout
localpackages = open(hostname.decode().strip())


current = subprocess.run(['pacman', '-Q'], check=True,
                         stdout=subprocess.PIPE).stdout

current = current.decode().split('\n')

hostname = hostname.strip()
if hostname.decode() == 'tardis':
    remotepackages = open('knine')
else:
    remotepackages = open('tardis')

remote = []
for p in remotepackages.readlines():
    remote.append(p.strip())

local = []
for p in localpackages.readlines():
    local.append(p.strip())
    package = p[:p.index(' ')]
    if p.strip() not in remote:
        subprocess.run(['sudo', 'pacman', '-R',  package])


for p in remote:
    package = p[:p.index(' ')]
    if p.strip() not in local:
        subprocess.run(['pacaur', '-S', '--needed', package])


for p in current:
    package = p[:p.index(' ')]
    if (p.strip() not in remote) and (p.strip() not in local):
        subprocess.run(['sudo', 'pacman', '-R',  package])
