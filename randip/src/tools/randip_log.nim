{.deadCodeElim: on, hints: on, warnings: off.}

import os, strutils, times

setCurrentDir("src/temp/")

var
  t = getTime().local
  captured = t.format("yyyy-dd-MM") & ".cap"
  errors = t.format("yyyy-dd-MM") & ".log"
  logged = "randip.census"
  output = open(captured, fmWrite)
  rolling* = open(errors, fmWrite)
  logging* = open(logged, fmAppend)

proc checkLen(testSeq: seq[string]): bool {.discardable.} =
  if testSeq.len == 0:
    output.write("[Empty]")
    output.write("\n")
  else:
    output.write(testSeq)
    output.write("\n")

proc writeToCap*(sucCon, sucSSH: seq[string]): bool {.discardable.} =
  output.write("Successful Connections \n")
  checkLen(sucCon)
  output.write("Successful SSH Connections \n")
  checkLen(sucSSH)
  output.close()
  return true
