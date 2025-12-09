#!/bin/bash

mode=$1
file=$2
value=$3

filename=$(basename "${file}")
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
new)
    echo "${value}" > "${file}"
;;
add)
    echo "${value}" >> "${file}"
;;
add-top)
    cat "${file}" > "${file}.top"
    echo "${value}" > "${file}"
    cat "${file}.top" >> "${file}"
    rm "${file}.top"
;;
add-top5)
    cat "${file}" > "${file}.top5"
    echo "${value}" > "${file}"
    cat "${file}.top5" | head -n 4 >> "${file}"
    rm "${file}.top5"
;;
add-top100)
    cat "${file}" > "${file}.top100"
    echo "${value}" > "${file}"
    cat "${file}.top100" | head -n 199 >> "${file}"
    rm "${file}.top100"
;;
add-bilanz)
    cat "${file}" | grep Datum > "${file}.bilanz"
    cat "${file}" | grep -v Datum | tail -n 36 >> "${file}.bilanz"
    cat "${file}.bilanz" > "${file}"
    echo "${value}" >> "${file}"
    rm "${file}.bilanz"
;;
empty)
    rm -rf "${file}"
    touch "${file}"
;;
esac

rm -rf "${LOCK_DIRNAME}"