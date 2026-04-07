[![Gem Version](https://badge.fury.io/rb/active_admin_sidebar.svg)](https://badge.fury.io/rb/active_admin_sidebar)
[![NPM Version](https://badge.fury.io/js/@activeadmin-plugins%2Factive_admin_sidebar.svg)](https://badge.fury.io/js/@activeadmin-plugins%2Factive_admin_sidebar)
![npm](https://img.shields.io/npm/dm/@activeadmin-plugins/active_admin_sidebar)
![Coverage](https://img.shields.io/endpoint?url=https://activeadmin-plugins.github.io/active_admin_sidebar/badge.json)

# ActiveAdmin Sidebar

Manipulate sidebar position and add collapsible sidebar support for ActiveAdmin 3.x.

## Install

Add to your `Gemfile`:

```ruby
gem 'active_admin_sidebar'
```

### Using assets via Sprockets

Add to `app/assets/stylesheets/active_admin.scss`:

```scss
@import "active_admin_sidebar";
```

Add to `app/assets/javascripts/active_admin.js`:

```javascript
//= require active_admin_sidebar
```

### Using assets via NPM

    $ npm i @activeadmin-plugins/active_admin_sidebar

Or

    $ yarn add @activeadmin-plugins/active_admin_sidebar

Add to `app/assets/javascripts/active_admin.js`:

```javascript
import '@activeadmin-plugins/active_admin_sidebar';
```

Add to `app/assets/stylesheets/active_admin.scss`:

```scss
@import '@activeadmin-plugins/active_admin_sidebar';
```

## Configuration per resource

Change sidebar position with `before_action`:

```ruby
# app/admin/posts.rb
ActiveAdmin.register Post do
  before_action only: [:index] do
    left_sidebar!
  end
end

# app/admin/comments.rb
ActiveAdmin.register Comment do
  before_action do
    right_sidebar!
  end
end
```

## Global configuration

Move sidebar to the left for all resources in `config/initializers/active_admin.rb`:

```ruby
ActiveAdmin.setup do |config|
  config.before_action do
    left_sidebar! if respond_to?(:left_sidebar!)
  end
end
```

## Collapsible sidebar

Add a toggle button to collapse/expand the sidebar. State is persisted per-resource across page navigations.

```ruby
# Collapsible sidebar (starts expanded)
left_sidebar!(collapsible: true)
right_sidebar!(collapsible: true)

# Collapsible sidebar (starts collapsed)
left_sidebar!(collapsible: true, start_collapsed: true)
right_sidebar!(collapsible: true, start_collapsed: true)
```

![Demo](https://activeadmin-plugins.github.io/active_admin_sidebar/demo.gif "Collapsible sidebar demo")
