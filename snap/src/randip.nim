#
#RandIP
#
#Architectures: x86_64, armv7l, aarch64, and haiku64
#
#Compiler options
{.deadCodeElim: on, hints: off, warnings: on.}
#
import random, strutils, fab, os, httpclient, net, nativesockets

import tools/randip_import, tools/randip_helper

import terminal

var
  sucCon*: seq[string]
  verStr*: string
  arguments = commandLineParams()
  ipAddr*: string
  exploit: bool

sucCon = @[]
verStr = "RandIP 1.9.6\n"


proc main(): bool =
  var
     ipAddr = genAddr()
     sock = newSocket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
  ipAddr = testAddr(ipAddr)
  try:
    echo "Connecting to " & ipAddr
    sock.connect(ipAddr, Port(80), 500 * 1)
    green("[+]Success! \n")
    sucCon.add(ipAddr & ", ")
    if log == true:
      logging.write(ipAddr & "\n")
    else:
      discard
    if http == true:
      getPage(ipAddr)
    else:
      echo "Skipping HTTP/S Probe on " & ipAddr & "\n"
    if ssh == true:
      getSSH(ipAddr, exploit)
    else:
      echo "Skipping SSH Probe on " & ipAddr & "\n"
    sleep(1500)#This is to eliminate hanging between consecutive connections
  except:
    errorHandler(0, ipAddr)
  finally:
    sock.close()

proc sshOnly(): bool =
  var
    ipAddr = genAddr()
    sock = newSocket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
  try:
    echo "Connecting to " & ipAddr
    sock.connect(ipAddr, Port(22), 500 * 1)
    green("[+]Success! \n")
    sucSSH.add(ipAddr & ", ")
    if exploit == true:
      exploitHandler(ipAddr, "sshEnum")
      exploitHandler(ipAddr, "sshLogin")
      exploitHandler(ipAddr, "openSSL")
    else:
      discard
  except:
    errorHandler(2, ipAddr)
  finally:
    sock.close()

proc handler() {. noconv .} =
  discard execShellCmd("clear")
  white(verStr)
  echo "Switched Arguments"
  blue("http: ", nl = false)
  white($(http), nl = false)
  blue(" ssh: ", nl = false)
  white($(ssh), nl = false)
  blue(" log: ", nl = false)
  white($(log), nl = false)
  blue(" ssl: ", nl = false)
  white($(ssl), nl = false)
  blue(" exploit: ", nl = false)
  white($(exploit), nl = false)
  echo "\n"
  good("Successful Connections\n")
  if sucCon.len == 0:
    red("[Empty]")
  else:
    echo "[$#]" % [intToStr(sucCon.len)]
    echo sucCon
  good("Successful SSH Connections\n")
  if sucSSH.len == 0:
    red("[Empty]")
  else:
    echo "[$#]" % [intToStr(sucSSH.len)]
    echo sucSSH
  green("\nPush c or type exit to either continue or quit")
  green("RandIP Shell:", nl = false)
  var hook: string = readLine(stdin)
  if hook == "exit":
    randipShell(hook, sucCon, sucSSh)
  elif hook == "writeLog":
    randipShell(hook, sucCon, sucSSh)
  else:
    randipShell(hook)

discard execShellCmd("clear")
white(verStr)
for arg in arguments:
  if "http:off" in arg:
    http = false
  elif "http:on" in arg:
    http = true
  elif "ssh:on" in arg:
    ssh = true
  elif "ssh:off" in arg:
    ssh = false
  elif "ssh:all" in arg:
    ssh = true
    sshAll = true
  elif "log:on" in arg:
    log = true
  elif "log:off" in arg:
    log = false
  elif "ssl:on" in arg:
    ssl = true
  elif "ssl:off" in arg:
    ssl = false
  elif "exploit:on" in arg:
    exploit = true
  elif "exploit:off" in arg:
    exploit = false
  elif "help" in arg:
    cmdHelp()
    quit(0)
  else:
    #Vanilla settings
    http = true
    ssh = true
    log = false
    ssl = false
    exploit = true

while true:
  setControlCHook(handler)
  if sshAll == true:
    discard sshOnly()
  else:
    discard main()

quit(0)
