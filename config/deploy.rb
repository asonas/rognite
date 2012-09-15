# config/deploy.rb

# capistranoの出力がカラーになる
require 'capistrano_colors'

# cap deploy時に自動で bundle install が実行される
require "bundler/capistrano"

# RVMを利用している場合は必要
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user

# リポジトリの設定
set :application, "rognite"
set :repository,  "git@github.com:sociareal/#{{rognite}}.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{application}"
set :rails_env, "production"

role :web, "rognite.asonas.jp:22"  #デプロイ先SSHポートを指定（デフォルトは22）
role :app, "rognite.asonas.jp:22"
role :db,  "rognite.asonas.jp:22", :primary => true

# SSHの設定
set :user, "www"
ssh_options[:port] = "22"
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# cap deploy:setup 後、/var/www/ の権限変更
namespace :setup do
  task :fix_permissions do
    sudo "chown -R #{user}.#{user} #{deploy_to}"
  end
end
after "deploy:setup", "setup:fix_permissions"
  
# Unicorn用に起動/停止タスクを変更
namespace :deploy do
  task :start, :roles => :app do
    run "cd #{current_path}; bundle exec unicorn_rails -c config/unicorn.rb -E #{rails_env} -D"
  end
  task :restart, :roles => :app do
    if File.exist? "/tmp/unicorn_#{application}.pid"
      run "kill -s USR2 `cat /tmp/unicorn_#{application}.pid`"
    end
  end
  task :stop, :roles => :app do
    run "kill -s QUIT `cat /tmp/unicorn.pid`"
  end
end

# Rails3.1.1のProduction用
namespace :assets do
  task :precompile, :roles => :web do
    run "cd #{current_path} && RAILS_ENV=production bundle exec rake assets:precompile"
  end
  task :cleanup, :roles => :web do
    run "cd #{current_path} && RAILS_ENV=production bundle exec rake assets:clean"
  end
end
after :deploy, "assets:prpecompile"