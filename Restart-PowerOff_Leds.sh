#!/bin/sh -e

CHIP=0
BUTTON_LINE_S=26
BUTTON_LINE_R=16
#LED5_YLW=5
#LED6_BLU=6
#Turn on Outer LED
gpioset gpiochip0 6=1
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
        sudo ip link set wlan0mon down
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
        sleep .5
        gpioset gpiochip0 5=1
        sudo reboot now
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

# Unexport the GPIO line when done
# gpio unexport $CHIP:$BUTTON_LINE #This doesnt work - gpio depreciated.
# Exit the script
exit 0
