#!/bin/sh
#
# /etc/rc.d/entrance: start/stop enlighted display manager
#

case $1 in

    start)
	/usr/sbin/entranced
	;;

    stop)
	pkill -f /usr/sbin/entranced
	;;

    restart)
	$0 stop
	sleep 2
	$0 start
	;;

    *)
	echo "usage: $0 [start|stop|restart]"
	;;

esac

# End of file
