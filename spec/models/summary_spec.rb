require File.dirname(__FILE__)+'/../spec_helper'

describe Summary do

  describe "basic_search" do
    it "should return results in alphabetical order" do
      @result_from_db = {"rows" => [summary_with_name("zubair"), summary_with_name("alice")]}
      Summary.stub(:search).with(any_args()).any_number_of_times().and_return(@result_from_db) 
      results = Summary.basic_search("alice", "")
      results.first()["name"].should =="alice"
      results.last()["name"].should == "zubair"
    end

    it "should return an empty array if there are no matching results" do
      Summary.stub(:search).with(any_args()).any_number_of_times() 
      results = Summary.basic_search( 'totally invalid name','absolutely not a valid id' )
      results.should == []
    end
  
    it "should append a wildcard to the end of search results" do
      Summary.should_receive(:search).with(anything(), "name:em*")
      Summary.basic_search("em", "")
    end    
  end
  def summary_with_name(name)
    sum = Summary.new
    sum["name"] = name
    sum
  end

end
