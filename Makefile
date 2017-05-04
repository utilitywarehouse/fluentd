build:
	docker build -t fluentd .
run-local:
	docker run -ti -v ${PWD}/fluent.conf.local:/etc/td-agent/td-agent.conf -v /tmp/in:/tmp/in fluentd
