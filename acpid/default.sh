#!/bin/sh
#@ Default acpi script that takes an entry for all actions

log() {
	logger -t /etc/acpi/default.sh "${*}"
}

set ${*}

# In order to not cumulate ACPI events actual actions should be detached
# from/to /dev/null and backgrounded via &
(
case "${1}" in
button/power)
	case "${2}" in
	PWRF)	/sbin/init 0;;
	*)	log "button/power action ${2} not handled (${*})";;
	esac
	;;
*)	log "ACPI group ${1} / action ${2} is not defined (${*})";;
esac
) </dev/null >/dev/null 2>&1 &
