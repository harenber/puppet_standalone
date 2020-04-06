# puppet_standalone
A simple Ubuntu container for puppet training 

This is just a Ubuntu in puppet to train puppet. It comes with a preinstalled puppet agent
and the repository of this book

https://www.packtpub.com/eu/networking-and-servers/puppet-5-beginners-guide-third-edition

and starts an sshd for easy login.

To start do something like this:

docker run -d --rm --name puppet --hostname puppet -e PASSWD=yourpasswd -p 1234:22 puppet_standalone

which will set "yourpasswd" as password and opens the sshd on port 1234.

DO THIS AT YOUR OWN RISK, YOU ARE OPENING AN SSHD TO A ROOT SHELL
