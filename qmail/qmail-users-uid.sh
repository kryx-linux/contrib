#!/bin/sh

groupadd -g 250 nofiles
useradd -u 250 -g nofiles -d /var/qmail/alias alias  -s /sbin/nologin
useradd -u 251 -g nofiles -d /var/qmail       qmaild -s /sbin/nologin
useradd -u 252 -g nofiles -d /var/qmail       qmaill -s /sbin/nologin
useradd -u 253 -g nofiles -d /var/qmail       qmailp -s /sbin/nologin

groupadd -g 251 qmail
useradd -u 254 -g qmail -d /var/qmail qmailq -s /sbin/nologin
useradd -u 255 -g qmail -d /var/qmail qmailr -s /sbin/nologin
useradd -u 256 -g qmail -d /var/qmail qmails -s /sbin/nologin
