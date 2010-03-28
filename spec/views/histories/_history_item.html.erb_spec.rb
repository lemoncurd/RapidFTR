require 'spec_helper'
describe "histories/_history_item.html.erb" do
  it "should render date and time of the edit and who did it" do
    render :locals => {:user_name=> "Barney", :datetime=>"July 19 2010 13:05"}
    response.should contain "Record was edited on July 19 2010 13:05 by Barney"
  end
end