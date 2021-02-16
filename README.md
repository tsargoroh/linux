#battery.sh<br /><br />
simple bash script for displaying battery status when called (for example if the device is laptop)<br />
upower utility is required, so sudo apt install upower if you don't have it
- download to directory /x/y/z      #any directory you want
- mv battery.sh battery             #renaming
- chmod o+x battery                 #giving all users permission to execute it
- export PATH=$PATH:/x/y/z          #adding /x/y/z to PATH so that you can call battery anytime anywhere
