module ActiveAdminSidebar
  module Positions
    def left_sidebar!
        @sidebar_position = :left
    end
    def right_sidebar!
        @sidebar_position = :right
    end

  end
end
