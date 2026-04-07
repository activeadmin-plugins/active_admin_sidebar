generate :model, 'author name:string{10}:uniq last_name:string birthday:date --force'
generate :model, 'post title:string:uniq body:text author:references --force'

inject_into_file "app/models/author.rb", "  validates_presence_of :name\n  validates_uniqueness_of :last_name\n", after: "ApplicationRecord\n"
inject_into_file "app/models/post.rb", "   validates_presence_of :author\n", after: ":author\n"

# Add ransackable_attributes for Ransack 4+
inject_into_file "app/models/author.rb",
  "  def self.ransackable_attributes(auth_object = nil)\n" \
  "    [\"name\", \"last_name\", \"birthday\", \"created_at\", \"updated_at\"]\n" \
  "  end\n",
  after: "ApplicationRecord\n"

inject_into_file "app/models/post.rb",
  "  def self.ransackable_attributes(auth_object = nil)\n" \
  "    [\"title\", \"body\", \"author_id\"]\n" \
  "  end\n" \
  "  def self.ransackable_associations(auth_object = nil)\n" \
  "    [\"author\"]\n" \
  "  end\n",
  after: "ApplicationRecord\n"

# Add our local Active Admin to the load path (Rails 7.1+)
gsub_file "config/environment.rb",
  'require_relative "application"',
  "require_relative \"application\"\n$LOAD_PATH.unshift('#{File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))}')\nrequire \"active_admin\"\n"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# Ensure Sprockets manifest exists (required by Rails 8+)
FileUtils.mkdir_p("app/assets/config")
File.write("app/assets/config/manifest.js",
  "//= link_directory ../javascripts .js\n//= link_directory ../stylesheets .css\n")

generate :'active_admin:install --skip-users'
generate :'formtastic:install'

# Initialize plugin
inject_into_file "config/initializers/active_admin.rb",
                 "  config.before_action do\n    left_sidebar!(collapsible: true) if respond_to?(:left_sidebar!)\n  end\n\n",
                 after: "ActiveAdmin.setup do |config|\n"

inject_into_file "app/assets/stylesheets/active_admin.scss",
                 "@import \"active_admin_sidebar\";\n",
                 after: "@import \"active_admin/base\";\n"

inject_into_file "app/assets/javascripts/active_admin.js",
  "//= require active_admin_sidebar\n",
  after: "//= require active_admin/base\n"

run "rm -rf test"
route "root :to => 'admin/dashboard#index'"
rake "db:migrate"

run "rm -f Gemfile Gemfile.lock"
