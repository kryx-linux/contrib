contrib/matrix-synapse README.md
================================

## Create a default config

Read [1].
Substitute `--server-name my.domain.name` with your settings.

```
cd /var/lib/synapse
sudo -u synapse /usr/bin/python3 -m synapse.app.homeserver \\
  --server-name my.domain.name \\
  --config-path /etc/synapse/homeserver.yaml \\
  --generate-config \\
  --report-stats=yes
```

## Databases

synapse uses sqlite by default, although postgresql is highly recommended
in terms of server performance.

If you want to use postgresql as your database backend, read [2] and install:
  - contrib/psycopg2

Then migrate the database as described in the manual.

## Caching

synapse can use redis, if you decide to have a complexer setup with workers.
In this case, install:
 - hiredis
 - python3-txredisapi
 - python3-hiredis

Then you can alter the config appropriately.

## Footnotes
[1]: https://matrix-org.github.io/synapse/latest/usage/configuration/homeserver_sample_config.html
[2]: https://matrix-org.github.io/synapse/latest/postgres.html
