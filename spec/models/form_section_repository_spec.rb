require "spec_helper"

describe "form section repository" do

  it "should return a form section for each form definition" do

    sectiondef1= FormSectionDefinition.new
    sectiondef2 = FormSectionDefinition.new

    FormSectionDefinition.stub!(:all).and_return([sectiondef1,sectiondef2])

    sections = FormSectionRepository.all

    sections.length.should == 2

  end
end