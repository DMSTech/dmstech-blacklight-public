set :rails_env, "production"
set :branch, "master"
set :deployment_host, "sul-dms-prod.stanford.edu"
set :bundle_without, [:deployment]

role :web, deployment_host
role :app, deployment_host
role :db,  deployment_host, :primary => true
