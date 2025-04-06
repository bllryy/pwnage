#!/bin/bash

exec socat TCP-LISTEN:1337,reuseaddr,fork EXEC:"nsjail -Mo \
  --chroot /srv \
  --user 31337 --group 31337 \
  --time_limit 30 \
  --disable_proc \
  --rlimit_as 64 \
  -- /srv/app/run",pty,stderr