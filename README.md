# TrashScript

Simple script written in POSIX shell, that realizing trash :recycle: functionality

# Overview 
Makefile in installation process creates file for collecting removed trash (by default `/tmp/trash`).
   1) `del <file>` - move file to trash.
   2) `del --clear` - remove files in trash with time from last acces is greater then `store_time` in config
   3) `del --clear-all` - remove all files in trash without checking time
   4) `del -n (--now) <file>` - remove files without moving it to trash 

If you wanna use another folder for trash, you should set it in installation process (`make TRASHDIR=/path/to/trash install`)

# Installation
Dependencies: you need some commands available in your system (mv, rm, ls, make)
  * download repository
  * run `make install`
