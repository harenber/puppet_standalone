FROM centos:7

RUN yum -y update; yum clean all && \
    yum -y install systemd; yum clean all; \
    (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/* && \
    rpm -U https://yum.puppet.com/puppet5-release-el-7.noarch.rpm && \
    yum -y update && \
    yum  install -y  puppet-agent epel-release && \
    yum install -y emacs-nox git openssh-server && \
    /opt/puppetlabs/puppet/bin/gem install r10k && \
    /opt/puppetlabs/puppet/bin/gem install generate-puppetfile && \
    ln -s /opt/puppetlabs/puppet/bin/r10k /opt/puppetlabs/bin && \
    ln -s /opt/puppetlabs/puppet/bin/generate-puppetfile /opt/puppetlabs/bin

ADD cmd.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/cmd.sh

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
    
    
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/local/bin/cmd.sh"]

