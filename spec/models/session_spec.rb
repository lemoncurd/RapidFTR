require 'spec_helper'

def test_usertype_matches_user(user_type)
  user = User.new :user_type => user_type
  Session.for_user(user).user_type.should == user_type
end

describe Session do

  describe "user_type" do
    it "should return Administrator when user is an administrator"
    test_usertype_matches_user('Administrator')

    it "should return User when user is a user"
    test_usertype_matches_user('User')
  end
end
