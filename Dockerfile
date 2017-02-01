FROM fluent/fluentd:v0.12-latest
USER root
RUN \
  apk --update add build-base ruby-dev curl && \
  gem install --no-document fluent-plugin-out-http-ext -v 0.1.9 && \
  gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 0.26.2 && \
  gem install --no-document fluent-plugin-concat -v 2.0.0 && \
  curl -s https://curl.haxx.se/ca/cacert.pem -o "$(ruby -ropenssl -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE')" && \
  apk del build-base ruby-dev curl && \
  rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

COPY fluent.conf /etc/fluentd/fluent.conf

CMD ["fluentd", "-qq", "-c", "/etc/fluentd/fluent.conf", "--use-v1-config", "--suppress-repeated-stacktrace"]
