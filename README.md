# fluentd

This repository is used to build a fluentd image that's used to ship logs from
kubernetes nodes.

It borrows heavily from
https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-elasticsearch/fluentd-es-image

# bullseye version

Current official fluentd images based on buster pack an older version of libsystemd that can't read logs from flatcar-2605-09-0 onwards.

As a temporary workaround we are building our own fluentd images from bullseye.

bullseye version lives in the `bullseye` branch
