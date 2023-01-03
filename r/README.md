R
=

## In case installing additional libraries fails

In my experience, for some reason, certain libraries try to link to an
outdated version of certain other system libraries.

Consider rebuilding all libraries from within a running R session.

```
$ r
> update.packages(checkBuilt = TRUE, ask = FALSE)
..
```
