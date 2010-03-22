require 'spec_helper'

describe HistoriesController do
  include LoggedIn
  def mock_child(stubs={})
    @mock_child ||= mock_model(Child, stubs)
  end
  it "should have restful route for GET" do
    assert_routing( {:method => 'get', :path => '/children/1/history'}, 
                    {:controller => "histories", :action => "show", :child_id => "1"})
  end
  
  it "should use child_id param when retrieving the child" do
    Child.stub(:get).and_return "some_child"
    Child.should_receive(:get).with "1"
    get :show, :child_id => "1"
  end

  it "should create child variable for view" do
    Child.stub(:get).and_return "some_child"
    get :show, :child_id => "some_id"
    assigns(:child).should == "some_child"
  end
  it "should put the history into the view data for the current child" do
      fred = Child.new( "name" => "Fred", "histories"=>"These are the changes" )
      Child.stub(:get).with("some_id").and_return fred
      get :show, :child_id => "some_id"
      assigns(:histories).should == "These are the changes"
  end
end