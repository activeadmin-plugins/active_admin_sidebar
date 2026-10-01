$:.push File.expand_path("../lib", __FILE__)
require "active_admin_sidebar/version"

Gem::Specification.new do |s|
  s.name        = "active_admin_sidebar"
  s.version     = ActiveAdminSidebar::VERSION
  s.authors     = ["Igor"]
  s.email       = ["fedoronchuk@gmail.com"]
  s.homepage    = "https://github.com/activeadmin-plugins/active_admin_sidebar"
  s.summary     = %q{active_admin_sidebar gem}
  s.description = %q{extension for activeadmin gem to manage sidebar}
  s.license     = "MIT"

  s.required_ruby_version = '>= 3.3'

  # Whitelist, not a reject list: a new directory in the repo does not
  # reach consumers until it is named here. The reject form needs a new
  # pattern every time the repo grows one, and that is how the
  # Capybara suite under spec/ ended up published in the first place.
  s.files         = `git ls-files -z -- lib app vendor config exe bin README.md LICENSE`.split("\x0")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activeadmin", ">= 3.0", "< 4.0"
end
