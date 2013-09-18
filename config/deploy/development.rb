set :rails_env, "development"
set :branch, "master"
set :deployment_host, "sul-dms-dev.stanford.edu"
set :bundle_without, [:deployment]

role :web, deployment_host
role :app, deployment_host
role :db,  deployment_host, :primary => true
