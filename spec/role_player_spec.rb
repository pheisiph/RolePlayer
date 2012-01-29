require 'spec_helper'
describe "RolePlayer" do

  let(:user) { user_class.new(:name => "Peter Pan") }

  describe "adding roles" do
    it "should result in roles" do
      user.add_role(:admin)
      user.roles.should eq [:admin]
    end
    
    it "should allow for multiple roles" do
      user.add_role(:moderator)
      user.add_role(:supervisor)
      user.roles.sort.should eq [:moderator, :supervisor].sort      
    end
    
    it "should not add a role twice" do
      user.add_role(:moderator)
      user.add_role(:moderator)
      user.roles.should eq [:moderator]
    end
  end
  
  describe "removing roles" do
    
    it "should retain remaining roles" do
      user.add_role(:moderator)
      user.add_role(:supervisor)
      user.remove_role(:moderator)
      user.roles.should eq [:supervisor]
    end
    
    it "should return an empty array if the last role is removed" do
      user.add_role(:moderator)
      user.add_role(:supervisor)
      user.remove_role(:moderator)
      user.remove_role(:supervisor)
      user.roles.should eq []
    end
    
    describe "with remove_role!" do
      
      it "should complain if the user doesn't have that role" do
        
        lambda {user.remove_role!(:moderator)}.should raise_error(RuntimeError, "This user does not have the role moderator")
        
      end
    end
    
  end
  
  context "#has_role?" do
    describe "if role is present" do
      it "should be true if only this role is present" do
        user.add_role(:admin)
        user.has_role?(:admin).should be_true
      end

      it "should be true if multiple roles are present" do
        user.add_role(:moderator)
        user.add_role(:supervisor)
        user.has_role?(:moderator).should be_true
      end
    end
    
    describe "if role is not present" do
      
      it "should be false if roles are empty" do
        user.has_role?(:admin).should be_false
      end
      
      it "should be false if other roles are present" do
        user.add_role(:moderator)
        user.add_role(:supervisor)
        user.has_role?(:admin).should be_false
      end
    end
    
  end
  
end