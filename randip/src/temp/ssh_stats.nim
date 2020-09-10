import strutils, streams, sequtils

var
  log = "ssh.log"
  input = newFileStream(log, fmRead)
  sshSeq0: seq[string]
  sshSeq1: seq[string]
  sshList = readAll(input)

sshSeq0 = @[]
sshSeq1 = @[]

for i in sshList.splitLines:
  sshSeq0.add(split(i)[0])

sshSeq1 = deduplicate(sshSeq0)
sshSeq1 = keepIf(sshSeq1, proc(x: string): bool = x != "")

for x in sshSeq1:
  echo x
  echo count(sshSeq0, x)
