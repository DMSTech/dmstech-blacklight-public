require 'bundler/setup'
require 'bundler/capistrano'
require 'dlss/capistrano'
require 'capistrano/ext/multistage'
require 'pathname'

set :stages, %W(development production)
set :default_stage, "development"
set :bundle_flags, "--quiet"

set :repository, "."
set :deploy_via, :copy

set :shared_children, %w(
  tmp
  log
  config/database.yml
  config/solr.yml
  config/stacks.yml
  config/parker-master.yml
)

set :user, "lyberadmin"
set :runner, "lyberadmin"
set :ssh_options, {
  :auth_methods  => %w(gssapi-with-mic publickey hostbased),
  :forward_agent => true
}

set :destination, "/home/lyberadmin"
set :application, "dms"

set :scm, :git
set :copy_cache, true
set :copy_exclude, [".git"]
set :use_sudo, false
set :keep_releases, 2

set :deploy_to, "#{destination}/#{application}"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy", "deploy:migrate"