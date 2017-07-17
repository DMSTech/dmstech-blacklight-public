lock '3.4.0'

set :application, 'dms'
set :repo_url, 'https://github.com/DMSTech/dmstech-blacklight-public.git'

# Default branch is :master
#ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'
set :deploy_to, "/home/lyberadmin/dms"

set :log_level, :debug

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{
  config/database.yml
  config/blacklight.yml
  config/stacks.yml
  config/secrets.yml
  config/parker-master.yml
  config/devise_secret
  config/honeybadger.yml
}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :honeybadger_env, fetch(:stage)
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

after "deploy", "deploy:migrate"
