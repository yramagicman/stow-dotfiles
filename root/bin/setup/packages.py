import subprocess
ar = ['zypper', 'ar', '-f']
lr = ['zypper', 'lr', '-u']
zypper = ['zypper', 'in']

default = open('./default_repos')
default_list = default.readlines()
default_list = [p.strip() for p in default_list]
default.close()

repos = subprocess.check_output(lr).decode().split('|')
repos = [r.strip() for r in repos if 'http' in r]
repos = [r[:-2].strip() for r in repos if 'http' in r]
packman = 'http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/'
dvd = 'http://opensuse-guide.org/repo/openSUSE_Leap_42.3/'

packman = open('./packman')
packman_list = packman.readlines()
packman_list = [p.strip() for p in packman_list]
packman.close()

if packman in repos:
    subprocess.call(ar + [packman, 'packman'])

dvd = open('./dvd')
dvd_list = dvd.readlines()
dvd_list = [p.strip() for p in dvd_list]
dvd.close()

if dvd in repos:
    subprocess.call(ar + [dvd, 'dvd'])

subprocess.call(['zypper', 'refresh'])
subprocess.call(zypper + default_list)
subprocess.call(zypper + ['--from', 'dvd'] + dvd_list)
subprocess.call(zypper + ['--from', 'packman'] + packman_list)
