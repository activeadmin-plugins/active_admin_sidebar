require 'active_admin'
require "active_admin_sidebar/version"
require 'active_admin_sidebar/activeadmin_views_pages_base'
require 'active_admin_sidebar/positions'

module ActiveAdminSidebar
  class Engine < Rails::Engine
      config.after_initialize do
          ActiveAdmin::BaseController.send :include, ActiveAdminSidebar::Positions
      end
  end
end



