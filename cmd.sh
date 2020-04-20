#!/bin/bash

/usr/sbin/sshd-keygen && /usr/sbin/sshd && echo "root:$PASSWD" | chpasswd

echo "Starting init..."
exec /usr/sbin/init 5
