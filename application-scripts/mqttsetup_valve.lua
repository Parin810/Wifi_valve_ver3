--creating client with the macid as the client id 
m = mqtt.Client(wifi.sta.getmac(),60)   --60sec keep alive
--lwt function sends the last will and testament message to tbe sent to the broker in case it goes offline
--m:lwt('lwt','offline',0,0)    

--mqtt offline function keeps checking whether the device has gone offline or not
m:on('offline',function(con) c = false end) 
-- on publish message receive event print the topic and data and do the task
m:on('message', function(conn, topic, data)
  print(topic .. ':')
  if topic == 'esp/'..macid..'/irrigate' then
	irrigate(data)
  
  -- if data ~= nil then
    -- print(data)
  -- end 
-- Use the data to turn the valve ON or OFF 
  
  elseif data == "1" then 
    startValve() 
  elseif data == "0" then 
    stopValve()
--to give the user the battery status 
  elseif data == "2" then   
    -- paylaod format identifier,bat3,bat6
    payload='1,'..tostring(bat3)..','..tostring(adc.read(0))
    m:publish('esp/'..macid..'/battery',payload,0,0, function(conn) end)
    print("Battery status sent ")  
  elseif data =="3" then 
	print ("sleep")
    node.dsleep(sleepTime)
   else
	 print(data)
  end
end)

function startValve()
	gpio.mode(pin4,gpio.OUTPUT) --enable driver IC
	gpio.write(pin4,gpio.LOW) --enable driver IC, PMOS ON
	tmr.delay(1000) -- time to settle
    	gpio.write(pin12,gpio.HIGH)
    	gpio.write(pin14,gpio.LOW)
    tmr.alarm(2,80,0,function()
	     gpio.write(pin12,gpio.LOW)
	     gpio.write(pin14,gpio.LOW)
    end)
    gpio.write(pin4,gpio.HIGH) --disable driver IC
  
end


function irrigate(r_time) --receive time from user
	Time = 1000000*30*r_time --multiply this with 30 seconds
	rtcmem.write32(5,string.byte('e')) --write flag to RTC memory
	startValve()
	tmr.stop(0) -- stop active device timer
	wifi.sta.disconnect() 
	print("sleep")
	node.dsleep(Time)
end

function stopValve()
	gpio.mode(pin4,gpio.OUTPUT) 
	gpio.write(pin4,gpio.LOW)
	tmr.delay(1000)
    gpio.write(pin14,gpio.HIGH)
    gpio.write(pin12,gpio.LOW)
     tmr.alarm(2,80,0,function()
	     gpio.write(pin12,gpio.LOW)
	     gpio.write(pin14,gpio.LOW)
     end)
	gpio.write(pin4,gpio.HIGH) --disable driver IC
end

