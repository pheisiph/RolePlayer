module Mongoid
  module RolePlayer
    module Helper
        # options are
        # opts = {
        #   :user => current_user,  # uses current_user by default, or :user if provided. If no user is provided, User.new (guest user) is assumed.
        #   :redirect => root_url,  # redirects to the path specified, or root_url if empty if user doesn't have access.
        #   :alert => "You do not have permission to access that."  # message sent to user, if user doesn't have access.
        # }
        def require_role(role, opts={})  # opts { :for  }
          
          opts = { :redirect => root_url,
            :alert => "You do not have permission to access that."
          }.merge(opts)

          user = current_user rescue opts[:user] || User.new # I don't want to instantiate a new user every time this is called, so we only do it if we have none
          unless user.has_role?(role)
            
            if block_given?
              yield(opts)
            else
              redirect_to opts[:redirect], :alert => opts[:alert] 
            end
          end
        end
    end
  end
end