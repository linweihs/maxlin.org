---
title: Devops Phone Interview
layout: post
class: post
tags: interview SRE devops script bash apple 
category: code
comments: true
---
## Devops Phone Interview

Given Columns of data from terminal. If I want you to display in diffent order and reverse string on certain column, how do you do that ?

For example, (I modify a bit, so I scrape data from ```/etc/passwd)

Display column 1, 2, 5, 3 in order and reverse string at column 5.

```
fthrock:x:26814:100:Frank Throckmorton:/home/fthrock:/usr/local/bin/bash
badger:x:38829:100:Wayne Badger:/home/badger:/usr/local/bin/bash
bwatt:x:97336:100:Brian J. Watt:/home/bwatt:/bin/bash
jans:x:29512:100:Jan Schaumann:/home/jans:/usr/local/bin/bash
pflaums:x:56393:100:Stephen Pflaum:/home/pflaums:/usr/local/bin/bash
kausar:x:85486:100:Kausar Khizra:/home/kausar:/usr/local/bin/bash
maxlin:x:86471:100:Wei-hsiang Lin:/home/maxlin:/usr/local/bin/bash
```

## Thoughts

Originally, I was thinking ```cut```, ```sed``` and ```awk```.

The ```cut``` can re-order column but has difficulty to reverse string on specific column.

e.g.

```bash
$ cut -d: -f1,2,5,3
```

The ```sed``` can throw in regex, but I have no clue how to reverse a string or reorder.


## Solution 

I study ```awk``` a bit and figure out this is one of way to achieve the result.

write a code snippet in awk and name it ```abc```.

Parse the data file like this...```cat /etc/passwd | awk -f abc```

```awk
function reverse(s)
{
  p = ""
  for(i=length(s); i > 0; i--) { p = p substr(s, i, 1) }
  return p
}

BEGIN {
  // field separator
  FS =":"
}

{
    $5 = reverse($5)
    print $1","$2","$5","$3
}
```
