FROM gcr.io/google_containers/ubuntu-slim:0.6

# Disable prompts from apt
ENV DEBIAN_FRONTEND noninteractive

# Install build tools
RUN apt-get -qq update && \
  apt-get install -y -qq curl ca-certificates gcc make bash sudo build-essential g++ && \
  apt-get install -y -qq --reinstall lsb-base lsb-release && \
  # Install logging agent and required gems
  /usr/bin/curl -sSL https://toolbelt.treasuredata.com/sh/install-ubuntu-xenial-td-agent2.sh | sh && \
  sed -i -e "s/USER=td-agent/USER=root/" -e "s/GROUP=td-agent/GROUP=root/" /etc/init.d/td-agent && \
  td-agent-gem install --no-document fluent-plugin-sumologic_output -v 0.0.3 && \
  td-agent-gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 0.26.2 && \
  td-agent-gem install --no-document fluent-plugin-detect-exceptions-with-error -v 0.0.3 && \
  td-agent-gem install --no-document fluent-plugin-systemd -v 0.0.5 && \
  # Remove build tools
  apt-get remove -y -qq gcc make build-essential g++ && \
  apt-get autoremove -y -qq && \
  apt-get clean -qq && \
  # Remove unnecessary files
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
      /opt/td-agent/embedded/share/doc \
      /opt/td-agent/embedded/share/gtk-doc \
      /opt/td-agent/embedded/lib/postgresql \
      /opt/td-agent/embedded/bin/postgres \
      /opt/td-agent/embedded/share/postgresql \
      /etc/td-agent/td-agent.conf

# Copy the Fluentd configuration file for logging Docker container logs.
COPY fluent.conf /etc/td-agent/td-agent.conf

# Copy the entrypoint for the container
COPY run.sh /run.sh

# Start Fluentd to pick up our config that watches Docker container logs.
CMD /run.sh $FLUENTD_ARGS
