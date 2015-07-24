# -----------------------------------------------------------------------------
# edenservers-teamspeak
#
# Builds an image of edenservers' teamspeak panel with teamspeak.
# (http://teamspeak.com/).
#
# Authors: Maxence Henneron
# Updated: July 22nd, 2015
# Require: Docker (http://www.docker.io/)
# Docker file inspired by Isaac Bythewood (http://www.github.com/overshard/docker-teamspeak)
# -----------------------------------------------------------------------------

# Base system is the LTS version of Ubuntu.
FROM   ruby:2.2.0

# Make sure we don't get notifications we can't answer during building.
ENV    DEBIAN_FRONTEND noninteractive

# Download and install everything from the repos.
RUN    apt-get --yes update; apt-get --yes upgrade
RUN    apt-get --yes install wget build-essential libpq-dev nodejs

# Install the panel
RUN mkdir /teamspeakpanel
WORKDIR /teamspeakpanel
ADD Gemfile /teamspeakpanel/Gemfile
RUN bundle install

# Download and install TeamSpeak 3
RUN    wget http://dl.4players.de/ts/releases/3.0.11.3/teamspeak3-server_linux-amd64-3.0.11.3.tar.gz
RUN    tar zxf teamspeak3-server_linux-amd64-3.0.11.3.tar.gz; mv teamspeak3-server_linux-amd64 /opt/teamspeak; rm teamspeak3-server_linux-amd64-3.0.11.3.tar.gz

ADD . /teamspeakpanel
RUN rake db:migrate

WORKDIR /

# Load in all of our config files.
ADD    ./scripts/start.sh /start

# Fix all permissions
RUN    chmod +x /start

# /start runs it.
EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033
EXPOSE 80

VOLUME ["/data"]
CMD    ["/start"]
