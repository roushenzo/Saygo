require 'bundler/capistrano'
set :application, "saygo"
set :deploy_to, "/home/ubuntu/saygo"
set :rails_env, 'production'
set :branch, 'master'
server 'dev.saygo.ru', :web, :app, :db, :primary => true
set :normalize_asset_timestamps, false

set :use_sudo, false
set :user, "ubuntu"
set :scm, :git
set :repository, "ubuntu@dev.saygo.ru:/home/ubuntu/saygo.git"
set :deploy_via, :remote_cache
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end

after "deploy:update_code", :symlink_config_files

task :symlink_config_files do
  symlinks = {
    "#{shared_path}/config/database.yml" => "#{release_path}/config/database.yml",
    "#{shared_path}/uploads" => "#{release_path}/public/uploads"
  }
  run symlinks.map{|from, to| "ln -nfs #{from} #{to}"}.join(" && ")
  run "chmod -R g+rw #{release_path}/public"
end
