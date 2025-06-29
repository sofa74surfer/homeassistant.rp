#!/bin/bash

rotseepark_up=$1
rotseepark_ftp=$2
rotseepark_file=$3

curl -T ${rotseepark_file} -u ${rotseepark_up} ${rotseepark_ftp}
