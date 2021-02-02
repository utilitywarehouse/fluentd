build:
	docker build -t fluentduw .
run-local:
	docker run -ti -v ${PWD}/fluent.conf.local:/etc/fluent/fluent.conf -v /tmp/in:/tmp/in fluentduw
