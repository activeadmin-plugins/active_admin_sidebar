(function() {
  $(document).ready(function() {
    var $aa_content, set_collapsed_sidebar, isLeftSidebar, collapseIcon, expandIcon;
    if ($('body').hasClass('index') && ($('#active_admin_content').hasClass('collapsible_sidebar'))) {
      $aa_content = $('#active_admin_content');
      isLeftSidebar = $aa_content.hasClass('left_sidebar');
      var isCollapsed = $aa_content.hasClass('collapsed_sidebar');

      if (isLeftSidebar) {
        collapseIcon = 'icono-caret-left';
        expandIcon = 'icono-caret-right';
      } else {
        collapseIcon = 'icono-caret-right';
        expandIcon = 'icono-caret-left';
      }

      var initialIcon = isCollapsed ? expandIcon : collapseIcon;
      var $toggleBtn = $('<span class="sidebar_toggle_btn ' + initialIcon + '" title="Toggle sidebar"></span>');

      // Place button inside #sidebar but outside .sidebar_section
      // so it stays visible when sections are hidden
      var $sidebar = $aa_content.find('#sidebar');
      $sidebar.prepend($toggleBtn);

      set_collapsed_sidebar = function(value) {
        return $.getJSON(this.href, {
          collapsed_sidebar: value
        });
      };

      $toggleBtn.on('click', function(e) {
        if (!$aa_content.hasClass('collapsed_sidebar')) {
          set_collapsed_sidebar(true);
          $aa_content.addClass('collapsed_sidebar');
          $toggleBtn.removeClass(collapseIcon).addClass(expandIcon);
          $aa_content.trigger('collapsible_sidebar:collapsed');
        } else {
          set_collapsed_sidebar(false);
          $aa_content.removeClass('collapsed_sidebar');
          $toggleBtn.removeClass(expandIcon).addClass(collapseIcon);
          $aa_content.trigger('collapsible_sidebar:uncollapsed');
        }
      });
    }
  });

}).call(this);
