#!/bin/bash

source chuboe.properties

IDDATE1=$(date +%Y%m%d)
IDDATE2=$(date +%Y-%m-%d)
CHUBOE_AWS_S3_BUCKET_SUB=$CHUBOE_PROP_DEBUG_DEV_SHARE_BUCKET
CHUBOE_AWS_S3_BUCKET=s3://$CHUBOE_AWS_S3_BUCKET_SUB/

echo date1=$IDDATE1
echo date2=$IDDATE2

echo copy log files to /tmp/
sudo rm -r /tmp/$IDDATE1/
mkdir -p /tmp/$IDDATE1/

echo cp $CHUBOE_PROP_IDEMPIERE_PATH/log/*$IDDATE1*.log /tmp/$IDDATE1/.
cp $CHUBOE_PROP_IDEMPIERE_PATH/log/*$IDDATE1*.log /tmp/$IDDATE1/.
echo cp $CHUBOE_PROP_IDEMPIERE_PATH/log/*$IDDATE2*.log /tmp/$IDDATE1/.
cp $CHUBOE_PROP_IDEMPIERE_PATH/log/*$IDDATE2*.log /tmp/$IDDATE1/.

cd /tmp/$IDDATE1/
for f in *; do mv "$f" "$CHUBOE_PROP_WEBUI_IDENTIFICATION"."$f"; done

echo Push files to S3...
echo aws s3 cp /tmp/$IDDATE1/ $CHUBOE_AWS_S3_BUCKET --recursive
aws s3 cp /tmp/$IDDATE1/ $CHUBOE_AWS_S3_BUCKET --recursive

echo files sent:
ls -ltrh /tmp/$IDDATE1/*

# see chuboe_obfuscation.sh for details on how to create dev s3 buckets
