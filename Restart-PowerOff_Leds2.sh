#!/bin/sh -e

CHIP=0
#Button 16 for Restart, 26 for Shutdown
BUTTON_LINE_S=26
BUTTON_LINE_R=16
#LED5_YLW=5
#LED6_BLU=6
#Turn on Outer LED
gpioset gpiochip0 6=1
gpioset gpiochip0 5=0
# Loop to monitor the button state
while true; do
    # Read the button state
    BUTTON_STATE_R=$(gpioget gpiochip$CHIP $BUTTON_LINE_R)
    BUTTON_STATE_S=$(gpioget gpiochip$CHIP $BUTTON_LINE_S)
    # If the button is pressed (state 0), Run terminal code
    if [ $BUTTON_STATE_R -eq 0 ]; then
        sleep .3
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sudo systemctl stop pwnagotchi
        sleep 1
        echo 'Pwnagotchi Stoped' | systemd-cat -p warning
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .5
        sudo systemctl stop bettercap
        sleep .3
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .5
        echo 'Bettercap Stoped' | systemd-cat -p warning
        sudo echo '1-1.3' |sudo tee /sys/bus/usb/drivers/usb/unbind
        #The below command may be better as sometimes the BUS and ID change.  
        #Wireless dongle may not come back up. If thats the case - comment out above
        #and use the below command with your lsusb results
        #sudo usb_modeswitch -v 0x0cf3 -p 0x9271 --reset-usb
        echo 'Unbind Wireless' | systemd-cat -p warning
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep 2
        sudo echo '1-1.3' |sudo tee /sys/bus/usb/drivers/usb/bind
        echo 'Bind Wireless' | systemd-cat -p warning
        sleep 2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep  2
        sudo ifconfig wlan0 down
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep  1
        sudo iwconfig wlan0 mode monitor
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep 1
        sudo ifconfig wlan0 up
        echo 'Wireless Reset' | systemd-cat -p warning
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .5
        sudo systemctl start bettercap 
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep 1
        echo 'Bettercap Started' | systemd-cat -p warning
        sudo systemctl start pwnagotchi
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep 1
        echo 'Pwnagotchi Started' | systemd-cat -p warning
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .5
        gpioset gpiochip0 5=1
        sleep 2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        #sudo reboot now
        break
    elif [ $BUTTON_STATE_S -eq 0 ]; then
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .5
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .5
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .2
        gpioset gpiochip0 5=1
        sleep .2
        gpioset gpiochip0 5=0
        sleep .5
        gpioset gpiochip0 5=1
        sudo shutdown -h now
        break 
    else
        echo -n
        #do nothing here at this point
        #gpioset gpiochip$CHIP $LED_LINE=0cd usr
    fi

    # Small delay to debounce the button
    sleep 0.1
done
#If this was a restart of the pwnagotchi services.Restart this sctipt.
#Or if Button still pressed - Reboot
sleep 1
BUTTON_STATE_X=$(gpioget gpiochip$CHIP $BUTTON_LINE_R)
if [ $BUTTON_STATE_X -eq 1 ]; then
     echo 'Restart Shell Script' | systemd-cat -p warning
     exec "$BASH" "$0" "$@"
     break
elif [ $BUTTON_STATE_X -eq 0 ]; then
     echo 'Reboot Requested. Rebooting...' | systemd-cat -p warning
     sudo reboot now
     break
fi
# Unexport the GPIO line when done
# gpio unexport $CHIP:$BUTTON_LINE #This doesnt work - gpio depreciated.
# Exit the script
exit 0
