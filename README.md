# ActiveAdmin Sidebar

Provides ability to manipulate sidebar position for ActiveAdmin (tested with ActiveAdmin ~> 1.0.0)

## Install

Add following line to the `Gemfile`

```ruby
gem 'active_admin_sidebar'
```

Add following line to the `app/assets/stylesheets/active_admin.css.scss`

```scss
  @import "active_admin_sidebar";
```

If you want to use collapsing feature, add following line

```javascripts
  //= require active_admin_sidebar
```

to the `app/assets/javascripts/active_admin.js`

# Configuration per resource

Changing sidebar position dynamically with before_action

```ruby
  # app/admin/posts.rb
  ActiveAdmin.register Post do
    before_action :left_sidebar!, only: [:show]
  end

  # app/admin/comments.rb
  ActiveAdmin.register Comment do
    before_action :right_sidebar!
  end
```

## Global configuration

Moving sidebar to the left within all resource. Set configuration in `config/initializers/active_admin.rb`

```ruby
  # == Controller before-actions
  #
  # You can add before, after and around actions to all of your resources
  ActiveAdmin.setup do |config|
    config.before_action do
      left_sidebar! if respond_to?(:left_sidebar!)
    end
  end
```

## Collapsing sidebar

You can use sidebar collapsing.
It will add "hide/show" button. Shown/Hidden state is persisted across all pages.

```ruby
  left_sidebar!(collapsed: true)
```

You can override button color according to your color theme. For example:

```scss
  body.active_admin {
    #active_admin_content.left_sidebar, #active_admin_content.collapsed_sidebar {
      .collapse_btn, .uncollapse_btn {
          background-color: #767270;
      }
    }
   }
```

Example

![Alt text](https://raw.githubusercontent.com/activeadmin-plugins/active_admin_sidebar/master/screen/sidebar.jpg "Example")
