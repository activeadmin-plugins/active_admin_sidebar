(function() {
  $(document).ready(function() {
    var $aa_content, set_collapsed_sidebar;
    if ($('body').hasClass('index') && ($('#active_admin_content').hasClass('collapsible_sidebar'))) {
      $aa_content = $('#active_admin_content');
      $aa_content.find('.sidebar_section:first>h3').append('<span class="collapse_btn icono-caret-left" title="Hide sidebar"></span>');
      $aa_content.prepend('<span class="uncollapse_btn icono-caret-right" title="Show sidebar"></span>');
      set_collapsed_sidebar = function(value) {
        return $.getJSON(this.href, {
          collapsed_sidebar: value
        });
      };
      return $aa_content.on('click', '.collapse_btn, .uncollapse_btn', function(e) {
        if (!$aa_content.hasClass('collapsed_sidebar')) {
          set_collapsed_sidebar(true);
          $aa_content.removeClass('left_sidebar');
          $aa_content.addClass('collapsed_sidebar');
          return $aa_content.trigger('collapsible_sidebar:collapsed');
        } else {
          set_collapsed_sidebar(false);
          $aa_content.removeClass('collapsed_sidebar');
          $aa_content.addClass('left_sidebar');
          return $aa_content.trigger('collapsible_sidebar:uncollapsed');
        }
      });
    }
  });

}).call(this);
