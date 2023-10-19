FROM ubuntu:22.04

# wget
RUN apt-get update && apt-get install -y \
  wget

# chrome
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get install -y ./google-chrome-stable_current_amd64.deb

# attributes
RUN apt-get update && apt-get install -y \
  dbus \
  xvfb

WORKDIR /app
COPY start-container.sh /app/start-container.sh
RUN chmod a+x /app/start-container.sh
RUN groupadd --gid 1000 chrome && useradd --uid 1000 --gid chrome -G sudo --shell /usr/bin/bash --create-home chrome
ENTRYPOINT [ "/app/start-container.sh" ]
