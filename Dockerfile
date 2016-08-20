FROM fluent/fluentd
USER root
RUN \
  apk --update add build-base ruby-dev curl && \
  gem install --no-document fluent-plugin-out-http-ext && \
  gem install --no-document fluent-plugin-kubernetes_metadata_filter && \
  curl -s https://curl.haxx.se/ca/cacert.pem -o "$(ruby -ropenssl -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE')" && \
  apk del build-base ruby-dev curl && \
  rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

CMD ["fluentd", "-c", "/etc/fluentd/fluent.conf", "--use-v1-config"]
