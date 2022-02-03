# Fluentd

This repository is used to build a fluentd image that's used to ship logs from
kubernetes nodes.

It borrows heavily from
https://github.com/kubernetes-sigs/instrumentation-addons/tree/master/fluentd-elasticsearch/fluentd-es-image

# Bullseye version

Current official fluentd images based on Buster pack an older version of
libsystemd that can't read logs from `flatcar-2605-09-0` onwards.

As a temporary workaround we are building our own fluentd images from Bullseye.
