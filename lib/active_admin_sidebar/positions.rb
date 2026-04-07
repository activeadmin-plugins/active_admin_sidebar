module ActiveAdminSidebar
  module Positions
    def left_sidebar!(options = {})
      @sidebar_options = { position: :left }

      collapsible = options.fetch(:collapsible, false)
      collapsed   = options.fetch(:collapsed, false)

      # Backward compatibility: `collapsed: true` without `collapsible:` means collapsible (not start-collapsed)
      if collapsed && !options.key?(:collapsible)
        collapsible = true
        collapsed = false
        ActiveSupport::Deprecation.warn(
          "left_sidebar!(collapsed: true) is deprecated. " \
          "Use left_sidebar!(collapsible: true) instead, or " \
          "left_sidebar!(collapsible: true, collapsed: true) to start collapsed."
        )
      end

      apply_collapsible_options(collapsible, collapsed) if collapsible
    end

    def right_sidebar!(options = {})
      @sidebar_options = { position: :right }

      collapsible = options.fetch(:collapsible, false)
      collapsed   = options.fetch(:collapsed, false)

      apply_collapsible_options(collapsible, collapsed) if collapsible
    end

    private

    def apply_collapsible_options(collapsible, collapsed)
      session_key = :"collapsed_sidebar_#{controller_name}"
      handle_collapsed_sidebar_request(session_key)
      is_collapsed = if session[session_key].nil?
                       collapsed
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
