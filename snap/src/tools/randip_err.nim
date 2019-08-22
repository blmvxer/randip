{.deadCodeElim: on, hints: on, warnings: off.}

import strutils, fab, randip_log

var
  signal*: int
  testSSH*: bool

export
  signal

proc errorHandler*(signal: int, host: string): bool {. discardable .} =
  let curErr = getCurrentExceptionMsg()
  for line in curErr.splitLines:
    if "Network is unreachable" in line:
      yellow("[~]Network unreachable \n")
    elif "Call to 'connect' timed out." in line:
      red("[-]Timed out... \n")
    elif "Connection timed out" in line:
      red("[-]Timed out... \n")
    elif "Call to 'readLine' timed out." in line:
      red("[-]Timed out... \n")
    elif "No route to host" in line:
       yellow("[~]No route to host \n")
#
    elif "400 Bad Request" in line:
      yellow("[~]400 Bad Request\n")
    elif "401 Unauthorized" in line:
      yellow("[~]401 Unauthorized\n")
    elif "401 Authorization Required" in line:
      yellow("[~]401 Authorization Required\n")
    elif "403 Forbidden" in line:
      yellow("[~]403 Forbidden\n")
    elif "404 Not Found" in line:
      yellow("[~]404 Not Found\n")
#
    elif "500 Internal Server Error" in line:
      yellow("[~]500 Internal Server Error\n")
    elif "500 Domain Not Found" in line:
      yellow("[~]500 Domain Not Found")
    elif "502 Bad Gateway" in line:
      yellow("[~]502 Bad Gateway\n")
    elif "503 Service Unavailable: Back-end server is at capacity" in line:
      yellow("[~]503 Service Unavailable: Back-end server is at capacity\n")
    elif "503 Service Unavailable" in line:
      yellow("[~]503 Service Unavailable\n")
#
    elif "SSL_shutdown:shutdown while in init" in line:
      yellow("[~]SSL_shutdown: shutdown while in init\n")#Nicest way of saying no https
    elif "Connection was closed before full request has been made" in line:
      red("[!]Connection was closed before full request has been made\n")
#
    elif "0x7f6d8037d478" in line:
      yellow("[~]Possible javascript password interface\n")
    elif "0x7f2c9a64a658" in line:
      yellow("[~]Invalid http version, possible proxy issue\n")
    elif "No uri scheme supplied" in line:
      yellow("[~]No urt scheme supplied\n")
    elif "Protocol not available" in line:
      yellow("[~]Protocol not available\n")
    elif "Additional info: Name or service not known" in line:
      yellow("[~]Additional info: Name or service not known\n")
    elif "Connection refused" in line:
      red("[-]Connection refused \n")
    elif "errno: 9 `Bad file descriptor`" in line:
      echo "Issue writing to log...\n"
      quit(1)
    elif "Protocol not supported" in line:
      red("[!]UDP Not Supported...")
      quit(1)
    else:
      purple(curErr)
      rolling.write(host & ": " & curErr & "\n")
      return true
