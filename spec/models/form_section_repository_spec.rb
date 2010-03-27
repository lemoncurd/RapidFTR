require "spec"

describe "form section repository" do

  it "should return a form section for each form definition" do

    #To change this template use File | Settings | File Templates.

    sectiondef1= FormSectionDefinition.new
    sectiondef2 = FormSectionDefinition.new

    sectiondefs = FormSectionDefinition.stub!(:all).and_return([sectiondef1,sectiondef2])

    sections = FormSectionRepository.all

    sections.length.should == 2
    

  end
end