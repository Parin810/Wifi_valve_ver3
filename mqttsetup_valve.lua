--creating client with the macid as the client id 
m = mqtt.Client(wifi.sta.getmac(),60)   --10sec keep alive
--lwt function sends the last will and testament message to tbe sent to the broker in case it goes offline
--m:lwt('lwt','offline',0,0)    

--mqtt offline function keeps checking whether the device has gone offline or not
m:on('offline',function(con) c = false end) 
-- on publish message receive event print the topic and data and do the task
m:on('message', function(conn, topic, data)
  print(topic .. ':')
  if topic == 'esp/'..macid..'/irrigate' then
	irrigate(data)
  end
  if data ~= nil then
    print(data)
  end 
-- Use the data to turn the valve ON or OFF 
  
  if data == "1" then 
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
  end
end)

function startValve()
	gpio.mode(pin13,gpio.OUTPUT)
	gpio.write(pin13,gpio.LOW)
	tmr.delay(1000)
    gpio.write(pin12,gpio.HIGH)
    gpio.write(pin14,gpio.LOW)

    tmr.alarm(2,80,0,function()
	     gpio.write(pin12,gpio.LOW)
	     gpio.write(pin14,gpio.LOW)
    end)
    
end


function irrigate(r_time)
	Time = 1000000*30*r_time
	rtcmem.write32(5,string.byte('e'))
	startValve()
	wifi.sta.disconnect()
	print("sleep")
	node.dsleep(Time)
end

function stopValve()
	gpio.mode(pin13,gpio.OUTPUT)
	gpio.write(pin13,gpio.LOW)
	tmr.delay(1000)
    gpio.write(pin14,gpio.HIGH)
    gpio.write(pin12,gpio.LOW)

     tmr.alarm(2,80,0,function()
	     gpio.write(pin12,gpio.LOW)
	     gpio.write(pin14,gpio.LOW)
     end)

end

