# RandIP 1.9.3
RandIP is a nim application that generates random IP address's and uses sockets to test whether the connection is valid or not with the additional test on Telnet and SSH.
<br>
Plans to update RandIP to work with Termux and Nim 1.X (12/5/2019)
<br>
<b>:Features:</b>
<br>

Added functionality is common and the script may change from day to day depending on development.
<br>

<b>#Changelog</b>
<br>
4/01/19:RandIP 1.9.0
<br>
RandIP shell - basic shell to control features off the application
<br>
Python exploits have been added
<br>
Many update to the logger and errorHandler code
<br>
Preparing to add documentation for API usuage
<br>
3/27/19:RandIP 1.6.5
<br>
Many fixes and bugs dealt with
<br>
Experimental features added.. check the code ;)
<br>
3/18/19:RandIP 1.6.1
<br>
Added RandIP make script
<br>
Updated RandIP Nim
<br>
Fixed typos and other basic mistakes
<br>
3/14/19:RandIP 1.6.0
<br>
Modulizing Nim version
<br>
3/8/19:RandIP 1.5.2
<br>
Preparing for Nim by default
<br>
3/5/19:RandIP 1.5.1
<br>
aarm64 build released
<br>
1/9/2019:RandIP 1.5
<br>
armv7l(armhf) build released
<br>
cleaned up directories
<br>
removed libnotify dep for armhf as they're mainly headless or console based
<br>
nightlies added for daily edge releases
<br>
1/3/2019:RandIP 1.4
<br>
Preparing for randip_status bot
<br>
1/1/2019:RandIP 1.3.8
<br>
snap stable released
<br>
-nim and -py command line arguments added
<br>
10/8/2018:RandIP 1.2.4
<br>
Bug fixes within SSH enumeration exploits
<br>
added false-positive tests on requests.ConnectionError
<br>
<br>
10/7/18:RandIP 1.2.3
<br>
Added SSH and Telnet Timeouts to prevent blocking
<br>
removed ShellShock exploit(no longer valid)
<br>
<br>
10/6/18:RandIP 1.2.1
<br>
SSH Enumerations now work in tandem
<br>
Typos fixed
<br>
Telnet crash fixed
<br>
AttrubuteError and TypeError on socket.herror fixed.
<br>
<br>
10/6/18:RandIP 1.2
<br>
added CVE: 2018-15473
<br>
added testing telnet and ssh on socket.herror
<br>
