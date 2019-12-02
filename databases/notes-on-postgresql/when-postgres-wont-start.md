---
description: >-
  This sometimes happens on my Mac when it reboots or otherwise doesn't shut
  down cleanly.
---

# When Postgres won't start

Look in console to see what is happening:

* syslog
* see if the launchd process is failing

Repairing things:

* stop the background service using homebrew:
* ```text
  brew services stop postgresql@10
  ```

* Try starting the process manually:
* ```text
  pg_ctl -D /usr/local/var/postgresql@10 start

  ```

* See if anything pops up, such as:
* ```text
  pg_ctl: another server might be running; trying to start server anyway
  waiting for server to start....2019-12-02 11:45:57.614 CST [27941] FATAL:  lock file "postmaster.pid" already exists
  2019-12-02 11:45:57.614 CST [27941] HINT:  Is another postmaster (PID 454) running in data directory "/usr/local/var/postgresql@10"?
   stopped waiting
  pg_ctl: could not start server
  Examine the log output.

  ```

  This likely means there's a stale `pid` file. Remove it and try again.

* ```text
  tamara@Mattimeo:kickserv:2019-12-02@11:46:18 (scratch)
  $ rm /usr/local/var/postgresql\@10/postmaster.pid 
  /usr/local/var/postgresql@10/postmaster.pid

  ```

  ```text
  tamara@Mattimeo:kickserv:2019-12-02@11:46:47 (scratch)
  $ brew services start postgresql@10
  ==> Successfully started `postgresql@10` (label: homebrew.mxcl.postgresql@10)

  ```

