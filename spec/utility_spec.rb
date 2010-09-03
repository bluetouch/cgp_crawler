require File.dirname(__FILE__) + "/spec_helper"
require File.expand_path(File.dirname(__FILE__) + "/../lib/utility")

describe "Utility" do
  
  describe "cycle" do
    before do
      @yields = []
    end
    
    it "should work, example 1" do
      options = {
        :max_iterations => 5
      }
      Cgp::Utility.cycle(options) do |x|
        @yields << x
        false
      end
      @yields.should == [0, 1, 2, 3, 4]
    end

    it "should work, example 2" do
      options = {
        :max_iterations => 9,
        :grow_by        => 1,
        :initial_max    => 2
      }
      Cgp::Utility.cycle(options) do |x|
        @yields << x
        false
      end
      @yields.should == [0, 1, 2, 0, 1, 2, 0, 1, 2]
    end

    it "should work, example 3" do
      options = {
        :max_iterations => 9,
        :grow_by        => 2,
        :initial_max    => 2
      }
      Cgp::Utility.cycle(options) do |x|
        @yields << x
        x == 1
      end
      @yields.should == [0, 1, 2, 3, 0, 1, 2, 3, 0]
    end

    it "should work, example 4" do
      options = {
        :max_iterations => 9,
        :grow_by        => 2,
        :initial_max    => 2
      }
      Cgp::Utility.cycle(options) do |x|
        @yields << x
        x == 3
      end
      @yields.should == [0, 1, 2, 0, 1, 2, 0, 1, 2]
    end

    it "should work, example 5" do
      options = {
        :max_iterations => 9,
        :grow_by        => 2,
        :initial_max    => 2
      }
      Cgp::Utility.cycle(options) do |x|
        @yields << x
        x == 1 || x == 3
      end
      @yields.should == [0, 1, 2, 3, 4, 5, 0, 1, 2]
    end

  end

end
