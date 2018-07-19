
ssid='ERTS LAB 101'
password='balstre101'


--configure gpio pins according to revised pin map
pin14 = 5
pin12 = 6
pin4 = 1
pin5 = 2
pin13 = 7

gpio.mode(pin14,gpio.OUTPUT) --in1 as output
gpio.mode(pin12,gpio.OUTPUT) --in2 as output
--

gpio.mode(pin13,gpio.OUTPUT) --control battery charging
gpio.write(pin13,gpio.HIGH)

gpio.write(pin12,gpio.LOW) --in1 for driver (sleep mode)
gpio.write(pin14,gpio.LOW) --in2 for driver (sleep mode)



node.setcpufreq(node.CPU80MHZ) --reduce operating freq for power saving

wifi.setmode(wifi.STATION)

wifi.sta.config(ssid,password)


wifi.sta.connect()

wifiAvailable=0 --initialising the flag 
sleepTime=1000000*60*10   --10 min sleep

dofile('connect1.lua')
