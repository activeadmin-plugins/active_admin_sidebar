desc "Creates a test rails app for the specs to run against"
task :setup do
  require 'rails/version'

  # --skip-javascript: the dummy app's own Gemfile is discarded (see
  # rails_template.rb) and the app boots under this gem's sprockets bundle, so
  # importmap-rails is never available. Rails 8.1 otherwise generates
  # `stale_when_importmap_changes` in ApplicationController and the app fails
  # to boot with a NameError.
  rails_new_opts = %w(
    --skip-turbolinks
    --skip-spring
    --skip-bootsnap
    --skip-javascript
    -m
    spec/support/rails_template.rb
  )
  system "bundle exec rails new spec/rails/rails-#{Rails::VERSION::STRING} #{rails_new_opts.join(' ')}"
end
