# xshred
Expanded shred with recursion and interactive mode.

run (`test.sh`) to create dummy files


run (`sudo install.sh`) to copy xshred.sh to /bin/xshred.

* Won't work.
```bash
$ xshred test/
``` 
* This will work.
```bash
$ xshred test/*
shred 'test/first'? [y/N] y
shred 'test/second'? [y/N] y
```
