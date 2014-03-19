active_admin_sidebar 
====================

easy change sidebar position with activeadmin (tested with active_admin-0.5.0)


Add including of css file 

  @import "active_admin_sidebar/index"; 

to the  app/assets/stylesheets/active_admin.css.scss


Changing sidebar position dynamically with before_filter

  # app/admin/posts.rb
  ActiveAdmin.register Post do
    before_filter :left_sidebar!, :only=>[:show]
  end

  # app/admin/comments.rb
  ActiveAdmin.register Comment do
    before_filter :right_sidebar!
  end



Moving sidebar to the left within all resource (config/initializers/active_admin.rb)


  # == Controller Filters
  #
  # You can add before, after and around filters to all of your
  # Active Admin resources from here.
  #
  config.before_filter :left_sidebar!

Disabling using sidebar layout on dashboards (if you setup sidebar position with initializer)

  ActiveAdmin.register_page "Dashboard" do
    controller {skip_before_filter :left_sidebar!}
    #.....
  end
  
Example

http://oi45.tinypic.com/1zx1a3r.png




