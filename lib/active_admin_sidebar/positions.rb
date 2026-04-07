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
      session_key = :"collapsed_sidebar_#{controller_name}"
      handle_collapsed_sidebar_request(session_key)
      is_collapsed = if session[session_key].nil?
                       start_collapsed
                     else
                       session[session_key]
                     end
      @sidebar_options.merge!(
        collapsible: true,
        is_collapsed: is_collapsed
      )
    end

    def handle_collapsed_sidebar_request(session_key)
      if request.xhr?
        if params[:collapsed_sidebar].present?
          collapsed = params[:collapsed_sidebar].to_s == 'true'
          session[session_key] = collapsed
          render json: { collapsed_sidebar: collapsed } and return
        end
      end
    end

  end
end
