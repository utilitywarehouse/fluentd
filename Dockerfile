# Modified version of https://github.com/fluent/fluentd-docker-image#debian-version
# but using Gemfiles instead of specifying the plugins

FROM fluent/fluentd:v1.16.0-debian-1.0

COPY entrypoint.sh /entrypoint.sh
COPY UpstreamGemfile /UpstreamGemfile
COPY UWGemfile /UWGemfile

# Needed to install things and to read system logs
USER root

# Install additional plugins
RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && sudo gem install --file UpstreamGemfile\
 && sudo gem install --file UWGemfile\
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

# Minimal config, override this file with production config
COPY fluent.conf /etc/fluent/fluent.conf

# Expose prometheus metrics
EXPOSE 80

ENTRYPOINT ["tini", "--", "/entrypoint.sh"]
