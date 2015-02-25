source 'https://rubygems.org'

#Rails Basis
#######################
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development
#################################

#Datenbanken
# Entwicklung Sqllite
group :development,:test do
  gem 'sqlite3'
end

# Heroku-Produktion Postgresql
group :production do
  gem 'pg'
  gem 'rails_12factor'
end


#1/5 Benutzer-Verwaltung
gem 'devise'

#2/5 Rollen-Verwaltung
gem 'rolify'
gem 'cancan'


#3/5 Page Routing
gem 'high_voltage'

#4/5 Bootstrap
gem "bootstrap-sass-rails", "~> 2.2.2.0"
gem 'devise-bootstrap-views'
gem 'therubyracer',  platforms: :ruby
gem 'font-awesome-sass'

#5/5 Testing
group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'faker'
  gem 'capybara'
end
# 6/6 Calendar
  gem 'fullcalendar-rails'
  gem 'momentjs-rails'
  gem 'responders'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


