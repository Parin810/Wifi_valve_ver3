
mqtt_broker_ip='10.129.152.8'
mqtt_port = 1883
qos = 0
wifi_timeout = 15 --15 seconds as timeout, 10 seconds also fine

macid = wifi.sta.getmac()
--wait for WiFi connection 
wifi_available=0
broker_connect_tries=0
tmr.alarm(1,1000,1,function()
	wifi_available=wifi_available+1
	if wifi.sta.getip()==nil then
		print("no wifi") --optional
		if wifi_available >= wifi_timeout then
			print('sleep') --optional
			node.dsleep(sleepTime)
		end
			--wifi_available = wifi_available+1
		else
		    print ('IP is '..wifi.sta.getip())
		    wifi_available=0
		    mqqt_connection()
	        end
	end)




function mqqt_connection()
	print ("in broker code")
	broker_connect_tries=broker_connect_tries + 1 
	dofile('mqttsetup_valve.lua') 
	m:connect(mqtt_broker_ip,mqtt_port,0,function(conn) 
		tmr.stop(1)
		--tmr.unregister(1)
		topic = 'esp/'..macid                 -- topic to subscribe to 
		topic1 = 'esp/'..macid ..'/irrigate'  -- topic to subscribe to 	
        m:subscribe({[topic]=0,[topic1]=0},function(conn) end)
		print('mqtt connected')
		payload=tostring(adc.read(0)) -- read adc value and convert to string
		m:publish('esp/'..macid..'/battery',payload,0,0, function(conn) end)
		print('battery status sent')
	end)     
end	

tmr.alarm(0,60000,1,function()  --sleeps after being active for 60seconds
	print("sleep")
	wifi.sta.disconnect()
	node.dsleep(sleepTime)
end)



