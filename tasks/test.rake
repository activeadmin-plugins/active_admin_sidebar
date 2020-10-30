desc "Creates a test rails app for the specs to run against"
task :setup do
  require 'rails/version'
  system("mkdir spec/rails") unless File.exists?("spec/rails")

  rails_new_opts = %w(
    --skip-turbolinks
    --skip-spring
    --skip-bootsnap
    --skip-webpack-install
    -m
    spec/support/rails_template.rb
  )
  system "bundle exec rails new spec/rails/rails-#{Rails::VERSION::STRING} #{rails_new_opts.join(' ')}"
end
