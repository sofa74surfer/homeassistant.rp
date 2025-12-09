#!/bin/bash

mode=$1
file1=$2
file2=$3

filename=$(basename "${file2}")
filename=${filename#./}
LOCK_DIRNAME="/share/${filename}.lock"
LOCAL_WAIT_MAX=30
LOCAL_WAIT=0
until mkdir "${LOCK_DIRNAME}" >/dev/null 2>&1
do
    if [ $LOCAL_WAIT -gt $LOCAL_WAIT_MAX ];
    then
        rm -rf "${LOCK_DIRNAME}"
        exit 1
    fi
	sleep 1
	(( LOCAL_WAIT += 1 )) 
done

case ${mode} in 
copy)
    if [ -e "${file1}" ] && [ ! -e "${file2}" ]; 
    then
        cp "${file1}" "${file2}"
    fi
;;
copy-replace)
    if [ -e "${file1}" ]; 
    then
        cp -f "${file1}" "${file2}"
    fi
;;
move)
    if [ -e "${file1}" ] && [ ! -e "${file2}" ]; 
    then
        mv "${file1}" "${file2}"
    fi
;;
move-replace)
    if [ -e "${file1}" ]; 
    then
        mv -f "${file1}" "${file2}"
    fi
;;
esac

rm -rf "${LOCK_DIRNAME}"