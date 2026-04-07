module ActiveAdminSidebar::ActiveAdminViewsPagesBase

  def build_page_content
    # When no sidebar options are set, fall back to vanilla ActiveAdmin behavior
    return super unless sidebar_options_present?

    build_flash_messages
    div id: "active_admin_content", class: main_content_classes do
      build_sidebar unless skip_sidebar? || right_sidebar?
      build_main_content_wrapper
      build_sidebar unless skip_sidebar? || left_sidebar?
    end
  end

  def build_sidebar
    if defined?(super)
      super
    else
      sidebar sidebar_sections_for_action, id: 'sidebar'
    end
  end

  def sidebar_options_present?
    assigns[:sidebar_options].present?
  end

  def left_sidebar?
    assigns[:sidebar_options].try!(:[], :position) == :left
  end

  def collapsible_sidebar?
    !!assigns[:sidebar_options].try!(:[], :collapsible)
  end

  def sidebar_is_collapsed?
    !!assigns[:sidebar_options].try!(:[], :is_collapsed)
  end

  def right_sidebar?
     !left_sidebar?
  end

  def main_content_classes
    classes = Arbre::HTML::ClassList.new
    if skip_sidebar?
      classes << "without_sidebar"
    else
      classes << "with_sidebar"
      classes << "left_sidebar" if left_sidebar?
      classes << "right_sidebar" if right_sidebar?
      if collapsible_sidebar?
        classes << "collapsible_sidebar"
        classes << "collapsed_sidebar" if sidebar_is_collapsed?
      end
    end
    classes
  end

end
