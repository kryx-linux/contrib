act_runner README
=================

## Registering a runner

From a root shell:

```
# cd /var/lib/act_runner
# act_runner register
INFO Registering runner, arch=amd64, os=linux, version=dev.
INFO Enter the Gitea instance URL (for example, https://gitea.com/):
https://your.gitea.tld
INFO Enter the runner token:
<redacted>
INFO Enter the runner name (if set empty, use hostname: kukfinanz.de):
default_runner
INFO Enter the runner labels, leave blank to use the default labels (comma-separated, for example, ubuntu-20.04:docker://node:16-bullseye,ubuntu-18.04:docker://node:16-buster,linux_arm:host):

INFO Registering runner, name=default_runner, instance=https://your.gitea.tld, labels=[ubuntu-latest:docker://node:16-bullseye ubuntu-22.04:docker://node:16-bullseye ubuntu-20.04:docker://node:16-bullseye ubuntu-18.04:docker://node:16-buster].
DEBU Successfully pinged the Gitea instance server
INFO Runner registered successfully.
```

This will create a .runner file needed to associate your runner with a gitea server.

## Changing settings

Copy the default config from `/usr/share/act_runner` to `/var/lib/act_runner`
and make any changes you need.
