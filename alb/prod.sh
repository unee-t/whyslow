#!/bin/bash

stage=prod
profile=uneet-$stage
account=192458993663

seetoday() {

	case $1 in
		bugzilla)
			;;
		meteor)
			;;
		*)
			echo "Unknown: $1"
			exit 1
			;;
	esac

	aws s3 --profile $profile sync s3://$stage-logs-unee-t/$1/AWSLogs/$account/elasticloadbalancing/ap-southeast-1/ $1
	zcat $1/$(date +'%Y/%m/%d/')*.log.gz | awk '{print $7, $4, $10, $13, $14, $15}' | sort
}


seetoday bugzilla
