#!/usr/bin/python -u

import sys
import datetime
import time 
def generate_sequence(begin, end):
    ''' begin and end are datetime.datetime objects '''
    date_t = datetime.datetime(begin[2], begin[1], begin[0])
    date_end = datetime.datetime(end[2], end[1], end[0])
    date_step = datetime.timedelta(days=1)
    
    limit_date=datetime.datetime.strptime("01052007", "%d%m%Y")

    while date_t <= date_end:
        mode = int(date_t >= limit_date)
        sys.stdout.write(str(mode) + " " + date_t.strftime('%d%m%Y') + '\n')
        sys.stdout.flush()
        #sys.stderr.write("Wrote " + date_t.strftime('%d%m%Y') + "\n")
        #sys.stderr.flush()
        date_t += date_step

if(len(sys.argv) == 1):
    read_from_stdin=True
elif(len(sys.argv) == 3):
    read_from_stdin=False
else:
    print("Usage: %s dd/mm/YYYY dd/mm/YYYY" % sys.argv[0])
    sys.exit(-1)


if(read_from_stdin):
    for line in sys.stdin:
        line_elements = line.split()
        generate_sequence(map(int, line_elements[0].split("/")),
                          map(int, line_elements[1].split("/")))
else:
        generate_sequence(map(int, sys.argv[1].split("/")),
                          map(int, sys.argv[2].split("/")))
