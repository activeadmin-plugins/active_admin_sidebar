# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'active_admin_sidebar/version'

Gem::Specification.new do |s|
  s.name        = 'active_admin_sidebar'
  s.version     = ActiveAdminSidebar::VERSION
  s.authors     = ['Igor']
  s.email       = ['fedoronchuk@gmail.com']
  s.homepage    = 'https://github.com/Fivell/active_admin_sidebar'
  s.summary     = 'active_admin_sidebar gem'
  s.description = 'extension for activeadmin gem to manage sidebar'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'activeadmin'
  s.add_dependency 'coffee-rails'
end
