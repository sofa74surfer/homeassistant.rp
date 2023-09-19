#!/bin/sh
RCA=0
RCB=0
RCC=0
RCD=0
I=0
# Serial Ordner lesen
SERIAL=`find /mnt/usb/* -type d -maxdepth 0 2> /dev/null`
RCA=$?
# Seriel dem Haus zuordnen
if [ $RCA -eq 0 ]
then
    case $SERIAL in 
    /mnt/usb/161213-F43)
        HAUS=19
        RCB=0
    ;;
    /mnt/usb/170612-00D)
        HAUS=21
        RCB=0
    ;;
    /mnt/usb/170612-00E)
        HAUS=23
        RCB=0
    ;;
    /mnt/usb/171016-001)
        HAUS=25
        RCB=0
    ;;
    *)
        HAUS=XX
        RCB=1
        RCC=999
        RCD=999
    ;;
    esac
fi

# Jedes File transferieren
if [ $RCB -eq 0 ]
then
    for FILE in $SERIAL/*
    do 
        if [ -f "$FILE" ] && [ $RCC -eq 0 ]
        then 
            ftpput -v -u hassio -p VXgzopxaFD3OlzVp 192.168.2.31 /share/luxtronik/dta/$HAUS/${FILE##*/} $FILE 1>/dev/null 2>/dev/null
            RCC=$?
            I=$((I+1))
        fi
    done
    if [ $RCC -ne 0 ]
    then
        RCD=999
    fi
fi

# Daten in Archiv Ordner verschieben
if [ $I -gt 0 ] && [ $RCC -eq 0 ]
then 
    DATUM=`date +"%y%m%d-%H%M" 2>/dev/null`
    RCD=$?
    if [ $RCD -eq 0 ]
    then
        mkdir ${SERIAL}/${DATUM} 1>/dev/null 2>/dev/null
        RCD=$?
    fi

    # DTA Files in das Archiv transferieren
    if [ $RCD -eq 0 ]
    then
        for FILE in ${SERIAL}/*.dta
        do
            if [ -f "$FILE" ] && [ $RCD -eq 0 ]
            then 
                mv ${FILE} ${SERIAL}/${DATUM}/ 1>/dev/null 2>/dev/null
                RCD=$?
            fi
        done
    fi    
    # CSV Files in das Archiv transferieren
    if [ $RCD -eq 0 ]
    then
        for FILE in ${SERIAL}/*.csv
        do
            if [ -f "$FILE" ] && [ $RCD -eq 0 ]
            then 
                mv ${FILE} ${SERIAL}/${DATUM}/ 1>/dev/null 2>/dev/null
                RCD=$?
            fi
        done
    fi    
    # ERR Files in das Archiv transferieren
    if [ $RCD -eq 0 ]
    then
        for FILE in ${SERIAL}/*.err
        do
            if [ -f "$FILE" ] && [ $RCD -eq 0 ]
            then 
                mv ${FILE} ${SERIAL}/${DATUM}/ 1>/dev/null 2>/dev/null
                RCD=$?
            fi
        done
    fi    
fi

echo "Return:$RCA-$RCB-$RCC-$RCC-$I"