require 'spec_helper'

describe Session do

  before(:each) do
    @user = User.new 
    @session = Session.for_user(@user)
  end

    it "admin? should return true when user is an administrator" do
      @user.user_type = "Administrator"
      Session.for_user(@user).admin?.should == true
    end


    it "admin? should return false when user is just a basic user" do
      @user.user_type = "BasicUser"
      Session.for_user(@user).admin?.should == false
    end
end
