FROM armv7/armhf-ubuntu
MAINTAINER Dominik Weidenfeld "dom.weidenfeld@gmail.com"

# Sources
#RUN sed -i "s/vivid main restricted/vivid main restricted multiverse/" /etc/apt/sources.list

# Update
RUN apt-get update && apt-get -y upgrade && apt-get clean
RUN apt-get install -y git supervisor avahi-utils libssl-dev libao-dev libpulse-dev libasound2-dev

# Folder Setup
RUN mkdir /var/run/dbus

# Shairport
RUN git clone https://github.com/abrasive/shairport.git /opt/shairport
RUN cd /opt/shairport && ./configure && make && make install && cd scripts/debian && cp -r * /etc
ADD shairport.conf /etc/default/shairport

# Add User
RUN adduser --system --disabled-login --ingroup audio shairport

### Clean
RUN apt-get -y autoclean
RUN apt-get -y clean
RUN apt-get -y autoremove

### Configure Supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Ports
EXPOSE 5000-5005 6000-6005/udp

### Start Supervisor
CMD ["/usr/bin/supervisord", "-n"]