# Scripts to help identify Unee-T slow requests on AWS

The elephant in the room is that there is no way to easy link slow HTTP
requests with their slow backend query by request ID. You best bet is matching
times. So there is a lot of guesswork being made.

https://wiki.mozilla.org/BMO/performance

## Profiling

	<@dylan> hendry: if you copy https://github.com/mozilla-bteam/bmo/blob/master/mod_perl.pl#L28-L39,
				   https://github.com/mozilla-bteam/bmo/blob/master/mod_perl.pl#L160-L168, and
				   https://github.com/mozilla-bteam/bmo/blob/master/mod_perl.pl#L171-L174, you can collect nytprof stats in the data/ dir for each request
	<@dylan> https://www.youtube.com/watch?v=1hrdVxI0uFM&t=1s <-- that's how I profile these days

## ALB

Assuming the ALB is configured to log to a bucket.

On the AWS Application Load Balancer (ALB) we scrutinise **TargetResponseTime**  and **request_url**.

What we know is that Bugzilla is much slower than the RDS backend!

## RDS

Assuming:

* slow_query_log 1
* log_output TABLE
* long_query_time 0.5
