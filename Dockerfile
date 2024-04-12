# syntax=docker/dockerfile:1

FROM ubuntu:latest
LABEL name="devenv"
WORKDIR /app
RUN apt-get  update && \
    apt-get install -y --no-install-recommends vim curl git python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*
RUN useradd -ms /bin/bash appdev
RUN chown -R appdev:appdev /app
USER appdev

CMD ["/bin/bash"]
