#!/bin/bash

set -e

if [ 2 != $# ]; then
    echo "usage: $0 s3://bucket/dir/root yyyy-mm-dd";
    exit 1;
fi

ROOTBUCKET=$1;
EVENTDATE=$2;
YEAR=`echo "$EVENTDATE" | cut -d '-' -f 1`
MONTH=`echo "$EVENTDATE" | cut -d '-' -f 2`
DAY=`echo "$EVENTDATE" | cut -d '-' -f 3`

wget http://data.githubarchive.org/$DATE-{0..23}.json.gz

S3DEST="$ROOTBUCKET/$YEAR/$MONTH/$DAY/"
s3cmd put *.json.gz "$S3DEST"
