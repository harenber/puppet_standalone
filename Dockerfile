FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install openssh-server wget vim emacs-nox && \
    cd /tmp && \
    wget https://apt.puppetlabs.com/puppet5-release-bionic.deb && \
    dpkg -i puppet5-release-bionic.deb && \
    apt-get update && \
    apt-get -y install puppet-agent r10k
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Clone the repo from this book for training purposes:
# https://www.packtpub.com/eu/networking-and-servers/puppet-5-beginners-guide-third-edition

RUN cd /root && git clone https://github.com/bitfield/puppet-beginners-guide-3.git

# start ssh and set password for the root user
CMD /etc/init.d/ssh start && echo "root:$PASSWD" | chpasswd && tail -f /dev/null