# Raspberry-Pi-Shell-Button-Shutdown
Shutdown or Restart Pi with shell script (kernel 6.6) libgpiod

Thanks too:
https://github.com/solarsamuel/raspi5_IO

https://www.youtube.com/watch?v=koUr7oOyUXY

https://www.ics.com/blog/gpio-programming-exploring-libgpiod-library #This was very helpful

https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/about/

https://www.ics.com/blog/gpio-programming-exploring-libgpiod-library


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


timedatectl set-ntp true &

bash /usr/scripts/reboot.sh &

exit 0



You will likely have to make rc.local executable (if the program does not run after a reboot, this is likely the solution): 

sudo chmod +x /etc/rc.local

Also - You will likely need to do the same to the BASH/SHELL scripts as well.  Reason - In one of my example scripts - 
The script restarts services, turns off the usb dongle, and restarts it.  Then the script needs to restart itself. 
Thus it needs permissions.  So 

sudo chmod +x /usr/scripts/yoursript.sh

 
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


NOTE - I could not get the board to pull the pin high (like you can in the python library) through shell script. So, I use the classic original way of doing it.

I pull the pin HIGH by wiring the pin through a 220 ohm resistor to 3.3v - Then the BUTTON is wired from the pin to GROUND.

The Shell script is looking for the pin to be LOW...
