FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install openssh-server wget vim emacs-nox ruby-dev && \
    cd /tmp && \
    wget https://apt.puppetlabs.com/puppet5-release-bionic.deb && \
    dpkg -i puppet5-release-bionic.deb && \
    apt-get update && \
    apt-get -y install puppet-agent r10k && \
    gem install generate-puppetfile
    
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Clone the repo from this book for training purposes:
# https://www.packtpub.com/eu/networking-and-servers/puppet-5-beginners-guide-third-edition

RUN cd /root && \
    git clone https://github.com/bitfield/puppet-beginners-guide-3.git && \
    git clone -b production https://github.com/bitfield/control-repo-3 && \
    mkdir /etc/puppetlabs/code/environments/new && cd /etc/puppetlabs/code/environments/new && \
    echo 'modulepath = "modules:site-modules:$basemodulepath"' > environment.conf && \
    cp ../production/hiera.yaml . && mkdir -p data/nodes && mkdir -p manifests && \
    mkdir -p site-modules/profile/manifests && mkdir -p site-modules/role/manifests && \
    echo "include(lookup('classes', Array[String], 'unique'))" > manifests/site.pp

# start ssh and set password for the root user
CMD /etc/init.d/ssh start && echo "root:$PASSWD" | chpasswd && tail -f /dev/null