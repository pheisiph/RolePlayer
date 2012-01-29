require "role_player/version"
require "role_player/helper"

module Mongoid
  module RolePlayer
    extend ActiveSupport::Concern
    
    included do
      field :roles,  type: Array, :default => []
    end
    
    module ClassMethods
    end
    

    def has_role?(role)
      raise "Expected Symbol got #{role.class.to_s}" unless role.is_a?(Symbol)
      roles.include?(role)
    end

    def add_role(role)
      roles << role unless has_role?(role)
    end
    
    def remove_role(role)
      roles.delete(role) if has_role?(role)
    end
    
    def remove_role!(role)
      if has_role?(role)
        roles.delete(role)
      else
        raise "This user does not have the role #{role.to_s}"
      end
    end
    # protected
    
  end

end
