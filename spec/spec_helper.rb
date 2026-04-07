require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH << File.expand_path('../support', __FILE__)

ENV['BUNDLE_GEMFILE'] = File.expand_path('../../Gemfile', __FILE__)
require "bundler"
Bundler.setup

ENV['RAILS_ENV'] = 'test'
require 'rails'
ENV['RAILS'] = Rails.version
ENV['RAILS_ROOT'] = File.expand_path("../rails/rails-#{ENV['RAILS']}", __FILE__)
unless File.exist?(ENV['RAILS_ROOT'])
  system 'rake setup'
end

require 'rails/all'
require 'active_admin'
ActiveAdmin.application.load_paths = [ENV['RAILS_ROOT'] + "/app/admin"]
require ENV['RAILS_ROOT'] + '/config/environment.rb'
ActiveAdmin.application.authentication_method = false
ActiveAdmin.application.current_user_method = false

require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'

require 'support/admin'
require 'support/capybara'

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    ActiveRecord::Migration.maintain_test_schema!
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
end
