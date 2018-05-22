#!/bin/bash
stage=prod

dbdomain() {
	if test $stage == "prod"
	then
		echo auroradb.unee-t.com
	else
		echo auroradb.$stage.unee-t.com
	fi
}

echo 'select * from slow_log WHERE start_time >=(CURRENT_DATE - INTERVAL 1 DAY) ORDER BY query_time\G;' |
mysql -h $(dbdomain $stage) -P 3306 -u root --password=$(aws --profile uneet-$stage ssm get-parameters --names MYSQL_ROOT_PASSWORD --with-decryption --query Parameters[0].Value --output text) mysql
