# ActiveAdminSidebar

Provides ability to manipulate sidebar position with activeadmin (tested with activeadmin ~> 1.0.0.pre)


Add including of css file 

```scss
  @import "active_admin_sidebar"; 
```

to the  
``` 
app/assets/stylesheets/active_admin.css.scss 
```

And including of coffee file (optional, need only for collapsed sidebar)

```js
  //= require active_admin_sidebar
```

to the  
``` 
app/assets/javascripts/active_admin.js
```

Changing sidebar position dynamically with before_filter
```ruby
  # app/admin/posts.rb
  ActiveAdmin.register Post do
    before_filter :left_sidebar!, only: [:show]
  end

  # app/admin/comments.rb
  ActiveAdmin.register Comment do
    before_filter :right_sidebar!
  end
```


Moving sidebar to the left within all resource (config/initializers/active_admin.rb)

```ruby
  # == Controller Filters
  #
  # You can add before, after and around filters to all of your
  # Active Admin resources from here.
  #
  config.before_filter do
    left_sidebar! if respond_to?(:left_sidebar!)
  end 
```

Also you can use sidebar collapsing. It will add css icon in title of first sidebar will save current state in session
```ruby
  left_sidebar!(collapsed: true)
```
You can override button color according to your color theme:
```css
  body.active_admin {
    #active_admin_content.left_sidebar, #active_admin_content.collapsed_sidebar {
      .collapse_btn, .uncollapse_btn {
          background-color: #767270;
      }
    }
   }
```

Example

http://oi45.tinypic.com/1zx1a3r.png




