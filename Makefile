build:
	docker build -t fluentd .
run-local:
	docker run -ti -v ${PWD}/fluent.conf.local:/etc/fluent/fluent.conf -v /tmp/in:/tmp/in fluentd
