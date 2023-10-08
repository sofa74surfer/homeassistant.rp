#!/bin/bash

luxtronik_ip=$1
luxtronik_user=$2
luxtronik_password=$3
ha_ip=$4
ha_user=$5
ha_password=$6

expect <<END
spawn telnet ${luxtronik_ip}
expect "(none) login:"
send "${luxtronik_user}\r"
expect "Password:"
send "${luxtronik_password}\r"
expect
send "/mnt/usb/transfer2ha.sh ${ha_ip} ${ha_user} ${ha_password}\r"
expect
send "exit\r"
expect eof
END
