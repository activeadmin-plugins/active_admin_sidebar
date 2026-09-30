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

  s.required_ruby_version = '>= 3.1.0'

  # Specs and CI config are dev-only — consumers download them and use
  # none of them. `s.test_files` is dropped: RubyGems deprecated it, and
  # it pointed at files this gem no longer ships.
  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|\.github)/}) }
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activeadmin", ">= 3.0", "< 4.0"
end
