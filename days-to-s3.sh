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
    ./date-to-s3.sh s3://mortar-mroddy-datasets/githubarchive $CURDATE;
    sleep $DELAY;
done
