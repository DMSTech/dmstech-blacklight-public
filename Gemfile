source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.8'

# Use sass-powered bootstrap
gem 'bootstrap-sass', "~> 3.3.6"
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# JS Runtime. See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
  gem 'mysql2', '~> 0.3.20'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'blacklight', "~> 5.18"

group :test do
  gem 'capybara'
  gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
end

group :deployment do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'dlss-capistrano', '~> 3.2'
end

  # Use sqlite3 as the database for Active Record
group :development do
  gem 'sqlite3'
end

gem "devise"
gem "devise-guests", "~> 0.3"
gem "rest-client"

# Use Squash for exception reporting
gem 'squash_ruby', require: 'squash/ruby'

# Pinned to 1.3.3 until https://github.com/SquareSquash/rails/pull/15
gem 'squash_rails', '1.3.3', require: 'squash/rails'
