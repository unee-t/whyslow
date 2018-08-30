#!/bin/bash
STAGE=dev

domain() {
	case $1 in
		prod) echo auroradb.unee-t.com
		;;
		*) echo auroradb.$1.unee-t.com
		;;
	esac
}

show_help() {
cat << EOF
Usage: ${0##*/} [-p]

By default, deploy to dev environment on AWS account 812644853088

	-p          PRODUCTION 192458993663
	-d          DEMO 915001051872

EOF
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
shift "$((OPTIND-1))"   # Discard the options and sentinel --

echo Connecting to ${STAGE^^} $(domain $STAGE)

echo 'select * from slow_log WHERE start_time >=(CURRENT_DATE - INTERVAL 1 DAY) ORDER BY query_time\G;' |
mysql -h $(domain $STAGE) -P 3306 -u root --password=$(aws --profile uneet-$STAGE ssm get-parameters --names MYSQL_ROOT_PASSWORD --with-decryption --query Parameters[0].Value --output text) mysql
