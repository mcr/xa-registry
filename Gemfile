source 'https://rubygems.org'

ruby "2.2.4"

# basics
gem 'rails', '4.2.4'
gem 'rails-observers'
gem 'responders', '~> 2.0'
gem 'slim-rails'
# gem 'uglifier', '>= 1.3.0'

# style
gem 'sass-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-rails'

# libraries
gem 'awesome_print'
gem 'devise'

# testing
gem 'factory_girl_rails'
gem 'faker'

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'pry-rails'
  gem "rspec-rails", "~> 3.0"
  gem 'database_cleaner'
end

group :production, :staging do
  gem 'pg'
  gem 'foreman'
  gem 'puma'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'thin'
end

