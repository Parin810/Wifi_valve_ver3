### Solar Harvesting IoT based Irrigation valve:
This repo contains all the necessary hardware and software information about IoT/Wifi Actuator that has the following features:
1. ESP8266 as the controller/radio chip 
2. Uses MQTT as the communication protocol
3. BQ24210 or MCP73831 based solar harvestor
4. Uses Nodemcu custom build firmware
5. Auto modem sleep enalbed (DTIM3,4,5)
6. The valve used is a latching solenoid 
7. DRV8832 as driver for latching solenoid
## Resources
The cheapst SOC that supports IEEE 802.11 standard
[ESP8266](https://tttapa.github.io/ESP8266/Chap04%20-%20Microcontroller.html)

Lua based firmware to simplify application programming
[Nodemcu - Lua](https://nodemcu.readthedocs.io/en/master/)

ESP8266 power consumption
[ESP8266 current profile](https://jeelabs.org/book/1526f/)

## Major Components Used 
(click to see datasheet)

[ESP8266-07](https://www.mikrocontroller.net/attachment/338570/Ai-thinker_ESP-07_WIFI_Module-EN.pdf)

LDO
[AP2112](https://www.diodes.com/assets/Datasheets/AP2112.pdf)

Lipo/ion charger
[MCP73831](http://ww1.microchip.com/downloads/en/DeviceDoc/20001984g.pdf)

Solar lipo/ion charger 
[BQ24210](http://www.ti.com/lit/ds/symlink/bq24210.pdf)

PMOS switch 
[PMV65XP](https://assets.nexperia.com/documents/data-sheet/PMV65XP.pdf)

## Loading LUA firmware
Download Nodemcu flasher from [here](https://github.com/nodemcu/nodemcu-flasher). for windows. For Linux use esptool.py (see repository for details)


