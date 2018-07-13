
--pin mappings for nodemcu lua
pin14 = 5
pin12 = 6
pin4 = 1
pin5 = 2
pin13 = 7

gpio.mode(pin14,gpio.OUTPUT) --in1 as output
gpio.mode(pin12,gpio.OUTPUT) --in2 as output
gpio.mode(pin13,gpio.OUTPUT) --control battery charging
gpio.write(pin13,gpio.HIGH) --set as high to disable charging initially


gpio.write(pin12,gpio.LOW) --in1 for driver (sleep mode)
gpio.write(pin14,gpio.LOW) --in2 for driver (sleep mode)

-- gpio.mode(pin4,gpio.OUTPUT) --enable driver IC
-- gpio.write(pin4,gpio.LOW) --enable driver IC, PMOS ON

node.setcpufreq(node.CPU80MHZ) --reduce operating freq for power saving

wifi.setmode(wifi.STATION)

--wifi.sta.config(ssid,password)


--rtcmem.write32(0,0,1)
--
val = rtcmem.read32(5) --read 5th slot of RTC memory
--val = string.char(val)
if val==101 then  --if 101 (decimal of 'e') implies valve on 
	gpio.mode(pin4,gpio.OUTPUT) --enable driver IC
	gpio.write(pin4,gpio.LOW) --enable driver IC, PMOS ON
	tmr.delay(1000) -- time to settle
	print ("stop")
	gpio.write(pin14,gpio.HIGH)
    	gpio.write(pin12,gpio.LOW)
	tmr.alarm(2,80,0,function()
	     gpio.write(pin12,gpio.LOW)
	     gpio.write(pin14,gpio.LOW)
     end)
     gpio.write(pin4,gpio.HIGH) --disable driver IC
end
print(val)
rtcmem.write32(5,0)

station_cfg={}
station_cfg.ssid="ERTS LAB 101"
station_cfg.pwd="balstre101"
--station_cfg.save=false
wifi.sta.config(station_cfg)

--use this for static ip allocation
-- cfg={
  -- ip = "192.168.1.123",
  -- netmask = "255.255.0.0",
  -- gateway = "192.168.1.1"
-- }

-- --wifi.sta.sleeptype(wifi.LIGHT_SLEEP)
--wifi.sta.setip(cfg)
wifi.sta.connect()




--configure gpio pins according to revised pin map

                                  

wifiAvailable=0 --initialising the flag 
sleepTime=1000000*60*10   --10 min sleep

dofile('connect1.lua')
