# Raspberry-Pi-Shell-Button-Shutdown
Shutdown or Restart Pi with shell script (kernel 6.6) libgpiod

Thanks too:
https://github.com/solarsamuel/raspi5_IO

https://www.youtube.com/watch?v=koUr7oOyUXY

https://www.ics.com/blog/gpio-programming-exploring-libgpiod-library #This was very helpful

The shell scripts written here are written with basic hacky coding skills and are not meant for production or commercial use.  These sripts are for educational use as an example.
Create a folder in the usr directory

sudo mkdir /usr/scripts #scripts dir created.

Copy the shell scripts into this directory (or the directory of your choosing).
To run restart.sh script whenever button is pressed - place command in rc.local or create your own service.

Go to /etc
Edit rc.local
sudo nano /etc/rc.local

add your shell execute command at the end above exit 0 with an ambersand (&) or above other commands with an ambersand (&)
like this :

#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

timedatectl set-ntp true &
sh /usr/scripts/test7.sh &
exit 0

NOTES:
#CHIP 0 is for pi 4 
CHIP=0  #gpiodetect to determine what chip.

BUTTON_LINE=26 #These are the pins attached to button or led.
LED_LINE=16

#This code blinks an LED that you attach to pin 16 (or whatever). This is just an example. Comment LED code out if no led attached.
#This code echos comments.  They are not needed.  Comment them out.
#This code stops services such as bettercap and pwnagotchi as examples.  Comment this out or use to stop other services.

Helpful code to run when button is pressed be like: 
touch /root/.pwnagotchi-auto && systemctl restart pwnagotchi # this should restart pwnagotchi (depending on version).
sudo shutdown -h now #shutdwon (with hault)
sudo shutdown -h -r now # version of reboot
sudo reboot now
sudo systemctl stop pwnagotchi && sudo pwnagotchi --clear && sudo shutdown -h now
sudo systemctl stop pwnagotchi && sudo pwnagotchi --clear && sudo shutdown -h now
