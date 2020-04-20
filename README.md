# puppet_standalone
A simple Linux container for puppet training

This is just a Ubuntu or CentOS 7 with puppet tools for puppet training.

It comes with a preinstalled puppet agent, r10k, generate-puppetfile, and emacs and the repository of this book

https://www.packtpub.com/eu/networking-and-servers/puppet-5-beginners-guide-third-edition

and starts an sshd for easy login.

To start do something like this:

docker run -d --rm --name puppet --hostname puppet -e PASSWD=yourpasswd -p 1234:22 harenber/puppet_standalone

(for Ubuntu) or

docker run -d --rm --privileged -v /sys/fs/cgroup:/sys/fs/cgroup --name puppet --hostname puppet -e PASSWD=yourpasswd -p 1234:22 harenber/puppet_standalone:CentOS7

(for CentOS7, as CentOS7 is based on systemd, you need to run privileged and mount cgroups. If your see errors like `invalid byte sequence in US-ASCII`, you may need to set `export LC_ALL="en_US.UTF-8"`)

which will set "yourpasswd" as password and opens the sshd on port 1234.

DO THIS AT YOUR OWN RISK, YOU ARE OPENING AN SSHD TO A ROOT SHELL

