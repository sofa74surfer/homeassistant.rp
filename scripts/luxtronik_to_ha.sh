#!/bin/bash

luxtronik_ip=$1
luxtronik_user=$2
luxtronik_password=$3

expect <<END
spawn telnet ${luxtronik_ip}
expect "(none) login:"
send "${luxtronik_user}\r"
expect "Password:"
send "${luxtronik_password}\r"
expect
send "/mnt/usb/transfer2ha.sh\r"
expect
send "exit\r"
expect eof
END
