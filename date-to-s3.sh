#!/bin/bash

set -e

if [ 3 != $# ]; then
    echo "usage: $0 s3://bucket/dir/root yyyy-mm-dd";
    exit 1;
fi

ROOTBUCKET=$1;
EVENTDATE=$2;
YEAR=`cut -d '-' -f 1 $EVENTDATE`
MONTH=`cut -d '-' -f 2 $EVENTDATE`
DAY=`cut -d '-' -f 3 $EVENTDATE`

wget http://data.githubarchive.org/2012-04-11-{0..23}.json.gz

S3DEST="$ROOTBUCKET/$YEAR/$MONTH/$DAY/"
s3cmd put *.json.gz "$S3DEST"
