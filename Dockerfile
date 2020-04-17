FROM centos:7

RUN rpm -U https://yum.puppet.com/puppet5-release-el-7.noarch.rpm && \
    yum -y update && \
    yum  install -y  puppet-agent epel-release && \
    yum install -y emacs-nox git openssh-server && \
    /opt/puppetlabs/puppet/bin/gem install r10k && \
    /opt/puppetlabs/puppet/bin/gem install generate-puppetfile && \
    ln -s /opt/puppetlabs/puppet/bin/r10k /opt/puppetlabs/bin && \
    ln -s /opt/puppetlabs/puppet/bin/generate-puppetfile /opt/puppetlabs/bin

# Clone the repo from this book for training purposes:
# https://www.packtpub.com/eu/networking-and-servers/puppet-5-beginners-guide-third-edition

RUN cd /root && \
    git clone https://github.com/bitfield/puppet-beginners-guide-3.git && \
    git clone -b production https://github.com/bitfield/control-repo-3

CMD /usr/sbin/sshd-keygen && /usr/sbin/sshd && echo "root:$PASSWD" | chpasswd && tail -f /dev/null

# FROM ubuntu:18.04

# RUN apt-get update && \
#     apt-get -y upgrade && \
#     apt-get -y install openssh-server wget vim emacs-nox ruby-dev && \
#     cd /tmp && \
#     wget https://apt.puppetlabs.com/puppet5-release-bionic.deb && \
#     dpkg -i puppet5-release-bionic.deb && \
#     apt-get update && \
#     apt-get -y install puppet-agent r10k && \
#     gem install generate-puppetfile
    
# RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# # Clone the repo from this book for training purposes:
# # https://www.packtpub.com/eu/networking-and-servers/puppet-5-beginners-guide-third-edition

# RUN cd /root && \
#     git clone https://github.com/bitfield/puppet-beginners-guide-3.git && \
#     git clone -b production https://github.com/bitfield/control-repo-3

# # start ssh and set password for the root user
# CMD /etc/init.d/ssh start && echo "root:$PASSWD" | chpasswd && tail -f /dev/null