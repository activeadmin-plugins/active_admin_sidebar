module ActiveAdminSidebar
  module Positions
    def left_sidebar!(options = {})
      @sidebar_options = { position: :left }
      if options.fetch(:collapsed, false)
        collapsed_sidebar
        @sidebar_options.merge!(
          is_collapsed: session[:collapsed_sidebar],
          collapsed: true
        )
      end
    end

    def right_sidebar!
      @sidebar_options = { position: :right }
    end

    def collapsed_sidebar
      if request.xhr?
        if params[:collapsed_sidebar].present?
          collapsed = ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include? params[:collapsed_sidebar]
          session[:collapsed_sidebar] = collapsed
          render json: { collapsed_sidebar: collapsed } and return
        end
      end
    end

  end
end
