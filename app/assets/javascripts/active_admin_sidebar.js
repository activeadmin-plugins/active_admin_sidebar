(function() {
  $(document).ready(function() {
    if ($('body').hasClass('index') && ($('#active_admin_content').hasClass('collapsible_sidebar'))) {
      var $aa_content = $('#active_admin_content');
      var $sidebar = $aa_content.find('#sidebar');

      var $toggleBtn = $('<span class="sidebar_toggle_btn" title="Toggle sidebar"><span class="chevron"></span></span>');
      $sidebar.prepend($toggleBtn);

      var set_collapsed_sidebar = function(value) {
        return $.getJSON(this.href, {
          collapsed_sidebar: value
        });
      };

      $toggleBtn.on('click', function(e) {
        if (!$aa_content.hasClass('collapsed_sidebar')) {
          set_collapsed_sidebar(true);
          $aa_content.addClass('collapsed_sidebar');
          $aa_content.trigger('collapsible_sidebar:collapsed');
        } else {
          set_collapsed_sidebar(false);
          $aa_content.removeClass('collapsed_sidebar');
          $aa_content.trigger('collapsible_sidebar:uncollapsed');
        }
      });
    }
  });
}).call(this);
