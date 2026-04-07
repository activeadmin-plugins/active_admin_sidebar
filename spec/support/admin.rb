def add_author_resource(options = {}, &block)

  ActiveAdmin.register Author do
    config.filters = true
  end

  Rails.application.reload_routes!

end

def add_author_resource_with_start_collapsed(options = {}, &block)

  ActiveAdmin.register Author do
    config.filters = true
    before_action do
      left_sidebar!(collapsible: true, start_collapsed: true)
    end
  end

  Rails.application.reload_routes!

end

def add_author_resource_right_sidebar(options = {}, &block)

  ActiveAdmin.register Author do
    config.filters = true
    before_action do
      right_sidebar!(collapsible: true)
    end
  end

  Rails.application.reload_routes!

end

def add_author_resource_right_sidebar_start_collapsed(options = {}, &block)

  ActiveAdmin.register Author do
    config.filters = true
    before_action do
      right_sidebar!(collapsible: true, start_collapsed: true)
    end
  end

  Rails.application.reload_routes!

end

def add_post_resource(options = {}, &block)

  ActiveAdmin.register Post do
    config.filters = true
    before_action :skip_sidebar!
  end

  Rails.application.reload_routes!

end

def add_post_resource_with_sidebar(options = {}, &block)

  ActiveAdmin.register Post do
    config.filters = true
    skip_before_action :skip_sidebar!, raise: false
    before_action do
      left_sidebar!(collapsible: true)
    end
  end

  Rails.application.reload_routes!

end
