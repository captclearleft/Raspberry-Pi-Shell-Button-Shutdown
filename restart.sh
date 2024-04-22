#!/bin/sh -e

#CHIP 0 is for pi 4 - use gpiodetect to determine what chip.
CHIP=0
BUTTON_LINE=26
LED_LINE=16
#This code blinks an LED that you attach to pin 16 (or whatever). This is just an example. Comment LED code out if no led attached.
#This code echos comments.  They are not needed.  Comment them out.
#Loop to monitor the button state
#This code stops services such as bettercap and pwnagotchi as examples.  Comment this out or use to stop other services.
#Other code could be: touch /root/.pwnagotchi-auto && systemctl restart pwnagotchi #put this in place of: sudo systemctl stop pwnagotchi.
while true; do
    # Read the button state
    BUTTON_STATE=$(gpioget gpiochip$CHIP $BUTTON_LINE)
    #LED turns on and off. This is not needed.  
    # If the button is pressed (state 0), turn on the LED
    if [ $BUTTON_STATE -eq 0 ]; then
        gpioset gpiochip$CHIP $LED_LINE=1
        sleep 1
        gpioset gpiochip$CHIP $LED_LINE=0
        sleep 1
        gpioset gpiochip$CHIP $LED_LINE=1
        sleep 1
        gpioset gpiochip$CHIP $LED_LINE=0
        sleep 1
        gpioset gpiochip$CHIP $LED_LINE=1
        sleep 1
        gpioset gpiochip$CHIP $LED_LINE=0
        sleep 1
        gpioset gpiochip$CHIP $LED_LINE=1
        sleep 1
        echo "Stopping Pwnagotchi"
        sudo systemctl stop pwnagotchi
        sleep 1
        echo "Stopping Bettercap"
        sudo systemctl stop bettercap
        sleep 1
        echo "Rebooting Now!!!"
        sudo reboot now
        break
    else
        gpioset gpiochip$CHIP $LED_LINE=0
    fi

    # Small delay to debounce the button
    sleep 0.1
done

# Unexport the GPIO line when done
#gpio unexport $CHIP:$BUTTON_LINE #This doesnt work - gpio depreciated.
# Exit the script
exit 0

