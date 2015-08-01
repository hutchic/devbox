# devbox

1. initial setup
  1. vagrant up
  2. vagrant ssh
  3. answer the prompts and wait until it finishes before proceeding
2. setup btsync
  1. 127.0.0.1:8888
  2. enter a key or link
  3. provide it the read/write key
  4. give it the directory `/var/lib/btsync/devbox/`
  5. wait until it syncs before proceeding
  6. run `./projects/devbox/btsync_symlinks.sh`
3. probably ansible(?)
