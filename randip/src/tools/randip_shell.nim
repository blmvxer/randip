{.deadCodeElim: on, hints: on, warnings: off.}

import fab, os, randip_err, randip_exploit, randip_log

var
  http*: bool
  ssh*: bool
  log*: bool
  ssl*: bool
  sshAll*: bool

proc cmdHelp*() =
  discard execShellCmd("clear")
  blue("Available Commands:")
  blue("Switches:")
  white("  http:on/off/?")
  white("  ssh:on/off/?")
  white("  log:on/off/?")
  white("  ssl:on/off/?")
  blue("Exploits:")
  white("  tBind")
  white(" sshEnum")
  white(" openSSL")
  blue("Other Commands:")
  white("  help")
  white("  writeLog")
  white("  exit\n")
  sleep(2500)


proc randipShell*(cmd: string): bool {.discardable.} =
  if cmd == "c":
    return true
  elif cmd == "":
    return true
#Exploits Go Here
  elif cmd == "tBind":
    green("Type host IP: ", nl = false)
    var host: string = readLine(stdin)
    exploitHandler(host, "tBind")
    return true
  elif cmd == "sshEnum":
    green("Type host IP: ", nl = false)
    var host: string = readLine(stdin)
    green("Type Username to test: ", nl = false)
    var user: string = readLine(stdin)
    exploitHandler(host, user, "sshEnum")
    return true
  elif cmd == "openSSL":
    green("Type host IP: ", nl = false)
    var host: string = readLine(stdin)
    exploitHandler(host, "openSSL")
    return true
#End Exploits
  elif cmd == "http:off":
    http = false
    return true
  elif cmd == "http:on":
    http = true
    return true
  elif cmd == "http:?":
    echo "Is HTTP/S Probe on?"
    echo http
    echo "\n"
    return true
  elif cmd == "ssh:on":
    ssh = true
    return true
  elif cmd == "ssh:off":
    ssh = false
    return true
  elif cmd == "ssh:all":
    ssh = true
    sshAll = true
    return true
  elif cmd == "ssh:?":
    echo "Is SSH Probe on?"
    echo ssh
    echo "\n"
    return true
  elif cmd == "log:on":
    log = true
    return true
  elif cmd == "log:off":
    log = false
    return true
  elif cmd == "log:?":
    echo "Are we logging every connection to randip.census?"
    echo log
    return true
  elif cmd == "ssl:on":
    ssl = true
    return true
  elif cmd == "ssl:off":
    ssl = false
    return true
  elif cmd == "ssl:?":
    echo "Are we running the ssl and ssh exploits?"
    echo ssl
    return true
  elif cmd == "test:?":
    echo testSSH
  elif cmd == "help":
    cmdHelp()
    return true
  else:
    quit(1)

proc randipShell*(cmd: string, sucCon, sucSSH: seq[string]): bool {.discardable.} =
  if cmd == "exit":
    writeToCap(sucCon, sucSSH)
    quit(0)
  elif cmd == "writeLog":
    writeToCap(sucCon, sucSSH)
    return true
  else:
    quit(1)
