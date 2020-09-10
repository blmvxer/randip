#!/bin/bash
#
#RandIP make script v1.0
#
#Compiler options added
#--cc=clang use clang compiler by default
#-x Run all check while compiling
#--threads prepare for multithreaded use
#-d:ssl use ssl
#-d:release build with release optimizations
#--opt:size compiler optimizations to decrease binary size
#--parallelBuild:0 similar to -jX on make
#
clear
ARCH=$(uname -m)
CUROS=$(uname)
NIMVER=$(nim -v | awk '{print $4; exit}')
REQVER="1.2.6"

if [ $ARCH = "x86_64" ]; then
   BIN=bin/x86_64
elif [ $ARCH = "aarch64" ]; then
   BIN=bin/aarm64
elif [ $CUROS = "haiku" ]; then
   if [ $ARCH = "x86_64" ]; then
       BIN=bin/haiku64
   else
      echo "$ARCH not supported"
      exit 1
   fi
else
   echo "$ARCH not supported"
   exit 1
fi

if [ ! -f src/randip.nim ]; then
  echo "src/randip.nim not found...exiting"
  exit 1
else
  if [ "$NIMVER" -ge "$REQVER" ]; then
    echo "Nim build found...Building against version $NIMVER $ARCH"
    echo "Beginning make on randip.nim"
    nim c --cc=gcc -x --nilseqs:on --hints:off -d:lineTrace -d:ssl --opt:size --passC:-Ofast -d:release --parallelBuild:0 --app:console src/randip.nim
    du -h src/randip
    if [ ! -f src/randip ]; then
      echo "Build Failed...Check error messages"
      rm src/randip
      exit 1
    else
      mv src/randip $BIN/randip_nim
      sha256sum $BIN/randip_nim > $BIN/sha256.md
      echo ""
      echo ""
      echo "Builds complete and sha256sum created..."
      cat $BIN/sha256.md
    fi
  else
    clear
    echo "Nim not installed or in Path or not version $REQVER"
    exit 1
  fi
fi
