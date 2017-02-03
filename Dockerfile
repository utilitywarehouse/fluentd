FROM fluent/fluentd:v0.12-latest
USER root
RUN \
  apk --no-cache add build-base ruby-dev curl && \
  gem install --no-document fluent-plugin-out-http-ext -v 0.1.9 && \
  gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 0.26.2 && \
  gem install --no-document fluent-plugin-detect-exceptions -v 0.0.4 && \
  gem install --no-document fluent-plugin-record-reformer -v 0.8.2 && \
  curl -s https://curl.haxx.se/ca/cacert.pem -o "$(ruby -ropenssl -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE')" && \
  apk del build-base ruby-dev curl && \
  rm -rf /tmp/* /var/tmp/*

COPY fluent.conf /etc/fluentd/fluent.conf

CMD ["fluentd", "-qq", "-c", "/etc/fluentd/fluent.conf", "--use-v1-config", "--suppress-repeated-stacktrace"]
