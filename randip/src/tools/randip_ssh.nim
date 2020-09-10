{.deadCodeElim: on, hints: on, warnings: off.}

import net, strutils, nativesockets, fab, os, streams
import randip_err, randip_exploit, randip_shell


var
  sucSSH: seq[string]
  sshVer = ""

export sucSSH, testSSH, sshVer

proc getSSH*(host: string, exploit: bool): bool {. discardable .} =
  var
    sock = newSocket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
  try:
    echo "Attempting SSH " & host
    sock.connect(host, Port(22), 250 * 1)
    green("[+]Success! \n")
    var output = newFileStream("ssh.log", fmAppend)
    sshVer = recvLine(sock, 250 * 1)
    grabSshVer(sshVer)
    yellow("SSH Probe: " & sshVer)
    output.write(sshVer & " - " & host & "\n")
    output.close()
    sucSSH.add(host & ", ")
    if ssl == true:
      exploitHandler(host, "sshEnum")
      exploitHandler(host, "openSSL")
      echo "\n"
    else:
      return true
  except:
    errorHandler(1, host)
  finally:
    if testSSH == true:
      exploitHandler(host, "sshEnum")
      exploitHandler(host, "sshLogin")
      exploitHandler(host, "openSSL")
      echo "\n"
      testSSH = false
    else:
      sock.close()
      return true
