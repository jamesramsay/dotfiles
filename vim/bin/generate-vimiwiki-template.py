#!/usr/bin/python
import sys
import datetime
import time
import os

template = """# {date}

## Important work

* [ ] Hiring
* [ ] Top strategy issue
* [ ] Top customer issue
* [ ] Planning
* [ ] Review emails (30mins)
* [ ] Review todos (30mins)

## Todo

## Notes"""

date = datetime.date.today()

if len(sys.argv) > 1:
        # Expecting path in /Users/john/vimwiki/<f>
        f = os.path.basename(sys.argv[1])

        # Expecting filename in YYYY-MM-DD.foo format
        time.strptime(os.path.splitext(f)[0], "%Y-%m-%d")

print(template.format(date=date.strftime("%A / %-d %b %Y")))
