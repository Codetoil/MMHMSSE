# syntax=docker/dockerfile:1
FROM swift:5.10-jammy

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

COPY .. ~/Game
WORKDIR ~/Game

RUN ./install-linux-x86_64.sh