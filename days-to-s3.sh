#!/bin/bash

set -e

if [ 3 != $# ]; then
    echo "usage: $0 yyyy-mm-dd numdays-to-export delay-between-days";
    exit 1;
fi

STARTDATE=$1
NUMDAYS=$2
DELAY=$3


START=`echo $STARTDATE | tr -d -`;

for (( c=0; c<$2; c++ )); do
    CURDATE=`date --date="$START +$c day" +%Y-%m-%d`;
    echo "Would Process: $CURDATE ";
    ./date-to-s3.sh s3://net.ednit.datasets/githubarchive $CURDATE;
    sleep $DELAY;
done
