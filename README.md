# Fluentd

Modified fluentd image for UW usage

It builds upon https://github.com/fluent/fluentd-docker-image using plugin versions from https://github.com/fluent/fluentd-kubernetes-daemonset 's `debian-s3` images (like https://github.com/fluent/fluentd-kubernetes-daemonset/blob/master/docker-image/v1.14/debian-s3/Gemfile)

We use `debian-s3` since it's the closest to what we want, and we can rely on their plugin versions combination to work, while only adding a few plugins ourselves

# Updating the image
* Update the `fluent/fluend` image tag in `Dockerfile`
* Update UpstreamGemfile pulling from upstream
* Update versions in UWGemfile, checking plugin's releases
