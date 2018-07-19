
mqtt_broker_ip='10.129.152.8'
mqtt_port = 1883
qos = 0
status=0
macid = wifi.sta.getmac()
wifi_timeout = 15 --15 seconds timeout

--wait for WiFi connection 
wifi_available=0
broker_connect_tries=0
tmr.alarm(1,1000,1,function()
	wifi_available=wifi_available+1
	if wifi.sta.getip()==nil then
		print("no wifi")
		if wifi_available >= wifi_timeout then
			print('timeout_sleep') --optional
			node.dsleep(sleepTime)
		end
		else
		    print ('IP is '..wifi.sta.getip())
			gpio.write(pin13,gpio.LOW) --enable solar charging
		    wifi_available=0
		    mqqt_connection()
	        end
	end)




	
	
function mqqt_connection()
	print ("in broker code")
	broker_connect_tries=broker_connect_tries + 1 --optional to keep track of tries
	dofile('mqttsetup_valve.lua') 
	m:connect(mqtt_broker_ip,mqtt_port,0,function(conn) 
		tmr.stop(1)
		topic = 'esp/'..macid                 -- topic to subscribe to 
		topic1 = 'esp/'..macid ..'/irrigate'  -- topic to subscribe to 
        m:subscribe(topic,0,function(conn) end)
		m:subscribe(topic1,0,function(conn) end)
		print('mqtt connected')
		payload=tostring(adc.read(0))
		m:publish('esp/'..macid..'/battery',payload,0,0, function(conn) end) --publish battery status
		print('battery status sent')
	end)     
end	

tmr.alarm(0,60000,1,function()  --sleeps after being active for 60seconds
	print("sleep")
	wifi.sta.disconnect()
	node.dsleep(sleepTime)
end)



