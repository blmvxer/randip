{.deadCodeElim: on, hints: on, warnings: off.}

import httpclient, fab, strutils, randip_err

proc getPage*(host: string): string {. discardable .} =
  var
    client = newHttpClient(maxRedirects = 5, timeout = 2000)
    url = "https://" & host#Use https to prevent hangs
  try:
    echo "HTTP/S Probe: $#" % host
    discard client.getContent(url)
    for line in client.getContent(url).splitLines:
      if "Invalid URL" in line:
        echo "Invalid URL \n"
      elif "IIS7" in line:
        echo "Found IIS Portal \n"
      elif "bitnami-xampp" in line:
        echo "Default XAMPP Server \n"
      elif "Bad Request" in line:
        red("[-]Bad Request \n")
      elif "Bluehost.Com" in line:
        green("[+]Default Blue Host Server \n")
      elif "Apache is functioning normally" in line:
        green("[+]Apache Server Found...\n")
      else:
        red("[~]Check Manually\n")
        errorHandler(3, host)
        break
  except:
    errorHandler(2, host)
  finally:
    client.close()
    return
