#!/bin/bash

STAGE=dev

show_help() {
cat << EOF
Usage: ${0##*/} [-p] SERVICE

By default, downloads logs from dev ALB for analysis

	-p          PRODUCTION 192458993663
	-d          DEMO 915001051872

EOF
}


acc() {
	case $1 in
		dev)  echo 812644853088
		;;
		demo) echo 915001051872
		;;
		prod) echo 192458993663
		;;
	esac
}

while getopts "pd" opt
do
	case $opt in
		p)
			echo "PRODUCTION" >&2
			STAGE=prod
			;;
		d)
			echo "DEMO" >&2
			STAGE=demo
			;;
		*)
			show_help >&2
			exit 1
			;;
	esac
done

AWS_PROFILE=uneet-$STAGE
shift "$((OPTIND-1))"

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

	aws s3 --profile $AWS_PROFILE sync s3://$STAGE-logs-unee-t/$1/AWSLogs/$(acc $STAGE)/elasticloadbalancing/ap-southeast-1/$(date +'%Y/%m/%d/') $STAGE-$1
	zcat $STAGE-$1/*.log.gz | awk '{print $7, $4, $10, $13, $14, $15}' | sort
}

seetoday ${1-bugzilla}
