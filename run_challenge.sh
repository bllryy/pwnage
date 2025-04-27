#!/bin/bash

# Run the challenge binary in an nsjail environment
/usr/bin/nsjail \
    --user 65534 \
    --group 65534 \
    --hostname pwnable \
    --max_cpus 1 \
    --time_limit 60 \
    --cgroup_mem_max 52428800 \
    --cgroup_pids_max 16 \
    --rlimit_as 209715200 \
    --rlimit_cpu 60 \
    --rlimit_fsize 104857600 \
    --rlimit_nofile 64 \
    --disable_clone_newcgroup \
    --disable_no_new_privs \
    --chroot / \
    --cwd /home/ctf/challenge \
    --forward_signals \
    -- /home/ctf/challenge/buffer_overflow
