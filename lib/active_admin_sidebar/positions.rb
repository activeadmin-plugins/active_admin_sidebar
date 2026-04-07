module ActiveAdminSidebar
  module Positions
    def left_sidebar!(options = {})
      @sidebar_options = { position: :left }

      validate_sidebar_options!(options)

      collapsible     = options.fetch(:collapsible, false)
      start_collapsed = options.fetch(:start_collapsed, false)

      apply_collapsible_options(start_collapsed) if collapsible
    end

    def right_sidebar!(options = {})
      @sidebar_options = { position: :right }

      validate_sidebar_options!(options)

      collapsible     = options.fetch(:collapsible, false)
      start_collapsed = options.fetch(:start_collapsed, false)

      apply_collapsible_options(start_collapsed) if collapsible
    end

    private

    def validate_sidebar_options!(options)
      if options.key?(:collapsed)
        raise ArgumentError,
          "The :collapsed option has been removed in v3. " \
          "Use `collapsible: true, start_collapsed: true` instead."
      end
    end

    def apply_collapsible_options(start_collapsed)
      handle_sidebar_toggle_request
      toggled = (session[:aas_toggled] || []).include?(controller_name)
      is_collapsed = toggled ? !start_collapsed : start_collapsed
      @sidebar_options.merge!(
        collapsible: true,
        is_collapsed: is_collapsed
      )
    end

    def handle_sidebar_toggle_request
      if request.xhr? && params[:collapsed_sidebar].present?
        toggled = session[:aas_toggled] || []
        if toggled.include?(controller_name)
          toggled -= [controller_name]
        else
          toggled += [controller_name]
        end
        session[:aas_toggled] = toggled
        render json: { collapsed_sidebar: params[:collapsed_sidebar] } and return
      end
    end

  end
end
