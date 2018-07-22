
# -*- coding: utf-8 -*-
import paho.mqtt.client as paho
import time 


def on_connect(client,userdata,flags,rc):
  print("CONNACK received with code %d" %(rc))
  print (time.ctime())
def on_subscribe(client, userdata, mid, granted_qos):
    print("Subscribed: "+str(mid)+" "+str(granted_qos))
    print  (time.ctime())

def on_message(client, userdata, msg):
    print(msg.topic+" "+str(msg.qos)+" "+str(msg.payload))
    f = open("algo2_batlog.txt",'a')
    f.write(str(msg.payload))
    print (time.ctime())
    t = time.ctime().split(" ")[3][0:5]
    f.write(","+ str(t) + "\n")
    f.close()
    client.publish("esp/5c:cf:7f:4c:2a:53","3", qos=0)
    #if str(t[0:5])=="11:50":
      #print "time matches"
    #else:
      
  
client = paho.Client()
client.on_connect = on_connect
client.on_subscribe = on_subscribe
client.on_message = on_message
client.connect("localhost", port=1883, keepalive=60)
client.subscribe("esp/5c:cf:7f:4c:2a:53/battery", qos=0)
client.loop_forever()

