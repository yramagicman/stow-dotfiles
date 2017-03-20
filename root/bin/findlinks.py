import fileinput
# f = open('./Lecture-notes-and-assignments.html')
links = []
for line in fileinput.input():
    if '<a href' in line:
        link = line.split(' ')
        for tag in link:
            t = tag.split('"')
            if 'href=' in t:
                print t[1]


# for l in links:
#  print l
