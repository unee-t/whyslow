#!/bin/bash
aws s3 --profile uneet-prod sync s3://prod-logs-unee-t/meteor/AWSLogs/192458993663/elasticloadbalancing/ap-southeast-1/ meteor
zcat meteor/$(date +'%Y/%m/%d/')*.log.gz | awk '{print $7, $13, $14, $15}' | sort
