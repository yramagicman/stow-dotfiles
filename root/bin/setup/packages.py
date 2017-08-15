import subprocess
default = open('./default_repos')
default_list = default.readlines()
default_list  = [p.strip() for p in default_list]
default.close()
zypper = ['zypper', 'in' ]
ar = ['zypper', 'ar', '-f']
subprocess.call(zypper + default_list)

packman = open('./packman')
packman_list = packman.readlines()
packman_list = [p.strip() for p in packman_list]
packman.close()

packman = 'http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/'

subprocess.call(ar + [packman, 'packman'] )
subprocess.call(['zypper', 'refresh'])
subprocess.call(zypper + ['--from', 'packman'] + packman_list)

dvd = open('./dvd')
dvd_list = dvd.readlines()
dvd_list  = [p.strip() for p in dvd_list]
dvd.close()
dvd = 'http://opensuse-guide.org/repo/openSUSE_Leap_42.3/'

subprocess.call(ar + [dvd, 'dvd'] )

subprocess.call(zypper + ['--from', 'dvd'] + dvd_list)
