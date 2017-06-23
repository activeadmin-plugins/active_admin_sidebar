def add_author_resource(options = {}, &block)

  ActiveAdmin.register Author do
    config.filters = true
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
