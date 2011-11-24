listen "/home/ubuntu/saygo/current/tmp/unicorn.sock"
worker_processes 2
timeout 30

pid "/home/ubuntu/saygo/shared/pids/unicorn.pid"
stderr_path "/home/ubuntu/saygo/shared/log/unicorn.log"
stdout_path "/home/ubuntu/saygo/shared/unicorn.log"
