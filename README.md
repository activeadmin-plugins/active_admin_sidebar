[![Gem Version](https://badge.fury.io/rb/active_admin_sidebar.svg)](https://badge.fury.io/rb/active_admin_sidebar)
[![NPM Version](https://badge.fury.io/js/@activeadmin-plugins%2Factive_admin_sidebar.svg)](https://badge.fury.io/js/@activeadmin-plugins%2Factive_admin_sidebar)
![npm](https://img.shields.io/npm/dm/@activeadmin-plugins/active_admin_sidebar)

# ActiveAdmin Sidebar

Provides ability to manipulate sidebar position for ActiveAdmin (tested with ActiveAdmin ~> 1.0.0)

## Install

Add following line to the `Gemfile`

```ruby
gem 'active_admin_sidebar'
```

##### Using assets via Sprockets
Add following line to the `app/assets/stylesheets/active_admin.css.scss`

```scss
  @import "active_admin_sidebar";
```

If you want to use collapsing feature, add following line

```javascripts
  //= require active_admin_sidebar
```

to the `app/assets/javascripts/active_admin.js`

##### Using assets via Webpacker (or any other assets bundler) as a NPM module (Yarn package)

Execute:

    $ npm i @activeadmin-plugins/active_admin_sidebar

Or

    $ yarn add @activeadmin-plugins/active_admin_sidebar

Or add manually to `package.json`:

```json
"dependencies": {
  "@activeadmin-plugins/active_admin_sidebar": "2.0.0"
}
```
and execute:

    $ yarn

Add the following line into `app/assets/javascripts/active_admin.js`:

```javascript
import '@activeadmin-plugins/active_admin_sidebar';
```

Add the following line into `app/assets/stylesheets/active_admin.scss`:

```css
@import '@activeadmin-plugins/active_admin_sidebar';
```

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
