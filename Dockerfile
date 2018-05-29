FROM phusion/baseimage:0.10.1

CMD ["/sbin/my_init"]

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

# Start as root
USER root

# Add a non-root user to prevent files being created with root permissions on host machine.
ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN groupadd -g ${PGID} daker && \
    useradd -u ${PUID} -g daker -m daker -G docker_env && \
    usermod -p "*" daker

# Run updates
RUN apt-get update -y && apt-get upgrade -y

# Setup the entrypoint
RUN mkdir -p /var/www/app
COPY entrypoint.sh /entrypoint.sh
COPY welcome.sh /welcome.sh
RUN chmod +x /entrypoint.sh /welcome.sh
VOLUME ["/var/www/app"]
WORKDIR /var/www/app
ENTRYPOINT ["/sbin/my_init", "--quiet", "--skip-startup-files", "--", "/entrypoint.sh"]
CMD ["/welcome.sh"]

# Create workspace folder for mounting
USER daker
RUN mkdir -p $HOME/.docker-workspace

# Clean up APT when done.
USER root
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
