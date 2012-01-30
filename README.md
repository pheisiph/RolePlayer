Mongoid::RolePlayer
=

A small and lightweight gem to add role-based authentication to a user model
in Mongoid. 

Install using `gem "role_player"` in your Gemfile. 

In your user model include `Mongoid::RolePlayer` to add a handful of methods:

```ruby
class User
include Mongoid::Document
include Mongoid::RolePlayer

  key :name, String
end
```

This will add an array of symbols representing a role a user has. You can manipulate them using the following convenience methods: 

```ruby
user.add_role(:admin)
user.has_role?(:admin)   # => true
user.remove_role(:admin)
user.has_role?(:admin)   # => false
```

In addition, you can include `Mongoid::RolePlayer::Helper` in your controller
to have your controller act to the presence (or lack) of a role. The helper
assumes that you have a helper method `current_user` that returns the currently
logged in user. You could then do something like this:

```ruby
class Admin::PostsController < ApplicationController
  include Mongoid::RolePlayer::Helper
  
  before_filter { require_role(:admin) }
  
  def index
   @posts = Post.all
  end
```

Since `require_role` takes the role symbol as a parameter you will need to 
pass it to `before_filter` in a block. It also accepts an optional options-hash like so:

```
opts = {
#   :user => current_user,  # uses current_user by default, or :user if provided. If no user is provided, User.new (guest user) is assumed.
#   :redirect => root_url,  # redirects to the path specified, or '/' if empty if user doesn't have access.
#   :alert => "You do not have permission to access that."  # message sent to user, if user doesn't have access.
# }
```

You can also pass a block to `require_role` which will overwrite the default
behavior (redirect with an alert message) and implement your own custom behavior like so:

```ruby
class Admin::PostsController < ApplicationController
  include Mongoid::RolePlayer::Helper
  
  before_filter do
    require_role :admin, { :alert => t(".noaccess")} do |opts|
      # the options hash gets passed through with defaults unless overridden
      redirect_to logout_path, :notice => opts[:alert]
    end
 end
  
  def index
   @posts = Post.all
  end
end
```

Why not just use can can?
-

Ryan Bate's CanCan is a really flexible and powerful solution, but in many cases I find
myself needing only a very simple solution: A user either has access to that page – or not. This admittedly very simple gem serves that purpose just fine.





