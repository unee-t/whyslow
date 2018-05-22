# Scripts to help identify Unee-T slow requests on AWS

The elephant in the room is that there is no way to easy link slow HTTP
requests with their slow backend query. So there is a lot of guesswork and
assumptions being made. Luckily the Bugzilla API is quite expressive with its
URLs.

Typically I'm told this problem is solved by instrumenting the application
code. Since Bugzilla is a bit of a black box, this isn't terribly realistic for
us.

## ALB

Assuming the ALB is configured to log to a bucket.

On the AWS Application Load Balancer (ALB) we scrutinise **TargetResponseTime**  and **request_url**.

## RDS

Assuming:

* slow_query_log 1
* log_output TABLE
* long_query_time 0.5
