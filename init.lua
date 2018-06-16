ssid = "ERTS LAB 304"
password = "balstre403"


wifi.setmode(wifi.STATION)
wifi.sta.config(ssid,password)

wifi.sta.disconnect()
--bat3=tostring(adc.readvdd33())
wifi.sta.connect()

--configure gpio pins according to revised pin map
pin14 = 5
pin12 = 6


gpio.mode(pin14,gpio.OUTPUT)
gpio.mode(pin12,gpio.OUTPUT)
gpio.write(pin14,gpio.LOW)
gpio.write(pin12,gpio.LOW)


c=false                                   --initialising the flag 
wifiAvailable=0
sleepTime=1000000*60*1    --1 min sleep
dofile('connect.lua')