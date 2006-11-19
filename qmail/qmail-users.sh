#!/bin/sh

groupadd nofiles
useradd -g nofiles -d /var/qmail/alias alias  -s /sbin/nologin
useradd -g nofiles -d /var/qmail       qmaild -s /sbin/nologin
useradd -g nofiles -d /var/qmail       qmaill -s /sbin/nologin
useradd -g nofiles -d /var/qmail       qmailp -s /sbin/nologin
groupadd qmail
useradd -g qmail -d /var/qmail qmailq -s /sbin/nologin
useradd -g qmail -d /var/qmail qmailr -s /sbin/nologin
useradd -g qmail -d /var/qmail qmails -s /sbin/nologin
