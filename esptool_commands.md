Use the follwoing command to flash the 2016 version of the firmware in the ESP8266 Board.

sudo python esptool.py --port /dev/ttyUSB0 write_flash 0x0000 nodemcu_integer_0.9.6-dev_20150704.bin 

Use the follwoing command to flash the 2018 version of the firmware in the ESP8266 Board.

sudo python esptool.py --port /dev/ttyUSB0 write_flash 0x3fc000 esp_init_data_default.bin

sudo python esptool.py --port /dev/ttyUSB0 write_flash 0x0000 nodemcu_master_18_modules_2018_integer.bin
