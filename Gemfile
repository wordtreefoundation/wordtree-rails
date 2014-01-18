source "https://rubygems.org"

gem 'archivist-client', github: "wordtreefoundation/archivist"

gem 'qless', '0.9.3'
gem 'fast_trie', '0.5.0'
gem 'activeadmin', github: "gregbell/active_admin"

gem 'omniauth'
gem 'omniauth-twitter', :github => "arunagw/omniauth-twitter"
gem 'omniauth-github', :github => "intridea/omniauth-github"

# Cached settings from https://github.com/huacnlee/rails-settings-cached
gem "rails-settings-cached", "0.3.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'debugger'
  gem 'rails-footnotes', :github => 'rrooding/rails-footnotes'
  gem 'sqlite3'
end

group :production do
  # Use postgresql
  gem 'pg'
end