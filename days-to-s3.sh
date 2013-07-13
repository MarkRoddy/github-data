#!/bin/bash

set -e

if [ 4 != $# ]; then
    echo "usage: $0 s3-path yyyy-mm-dd numdays-to-export delay-between-days";
    exit 1;
fi

S3_PATH=$1
STARTDATE=$2
NUMDAYS=$3
DELAY=$4

START=`echo $STARTDATE | tr -d -`;

for (( c=0; c<$3; c++ )); do
    # CURDATE=`date --date="$START +$c day" +%Y-%m-%d`;
    PYFORMATDATE=$(cat <<EOF
from datetime import datetime, timedelta;
START_DATE="$STARTDATE"
y,m,d = map(int, START_DATE.split('-'))
dt=datetime(y,m,d)
new_dt=dt + timedelta(days=$c)
print "%s-%02d-%02d" % (new_dt.year, new_dt.month, new_dt.day)
EOF
)
    CURDATE=`python -c "$PYFORMATDATE"`
    echo "Would Process: $CURDATE ";
    ./date-to-s3.sh $S3_PATH $CURDATE;
    sleep $DELAY;
done
