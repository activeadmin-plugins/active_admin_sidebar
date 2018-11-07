source 'https://rubygems.org'

# Specify your gem's dependencies in activeadmin_scoped_collection_actions.gemspec
gemspec

group :test do
  gem 'rails', "#{ENV['RAILS'] || '5.2.1'}"
  if ENV['AA'] == '1-4-stable'
    gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin.git', branch: '1-4-stable'
  else
    gem 'activeadmin', "#{ENV['AA'] || '1.3.1'}"
  end

  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'byebug'
end
