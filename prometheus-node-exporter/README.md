prometheus-node-exporter README
===============================

## Generating a password

For generating a password you either need opt/apache installed to be able
to use `htpasswd -nBC 10 "" | tr -d ':\'; echo` or use install
`contrib/python3-bcrypt` and use
`/usr/lib/prometheus-node-exporter/gen-pass.py`. Use the generated password
hash to fill in the skeleton under `/etc/node-exporter/config.yml`.

## Using tls

Generate a valid certificate according to the `config.yml` or use a proper one.
If you use a self signed certificate you will make your prometheus scraper
trust it.
