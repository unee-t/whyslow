#!/bin/bash
echo 'select * from slow_log\G;' |
mysql -h auroradb.dev.unee-t.com -P 3306 -u root --password=$(aws --profile uneet-dev ssm get-parameters --names MYSQL_ROOT_PASSWORD --with-decryption --query Parameters[0].Value --output text) mysql
