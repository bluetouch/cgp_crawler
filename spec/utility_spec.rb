require File.dirname(__FILE__) + "/spec_helper"
require File.expand_path(File.dirname(__FILE__) + "/../lib/utility")

describe "Utility" do
  
  describe "cycle" do
    before do
      @yields = []
    end

    it "break after 5" do
      options = {}
      n = 0
      Cgp::Utility.cycle(options) do |x|
        @yields << x
        n += 1
        break if n >= 5
        false
      end
      @yields.should == [0, 1, 2, 3, 4]
    end

    it "min, initial_max, break after 7" do
      options = {
        :min         => 2,
        :initial_max => 4
      }
      n = 0
      Cgp::Utility.cycle(options) do |x|
        @yields << x
        n += 1
        break if n >= 7
        false
      end
      @yields.should == [2, 3, 4, 2, 3, 4, 2]
    end

    it "start_at, min, initial_max, break after 7" do
      options = {
        :start_at    => 3,
        :min         => 2,
        :initial_max => 4
      }
      n = 0
      Cgp::Utility.cycle(options) do |x|
        @yields << x
        n += 1
        break if n >= 7
        false
      end
      @yields.should == [3, 4, 2, 3, 4, 2, 3]
    end

    it "max_iterations, find always false" do
      options = {
        :max_iterations => 5
      }
      Cgp::Utility.cycle(options) do |x|
        @yields << x
        false
      end
      @yields.should == [0, 1, 2, 3, 4]
    end

    it "max_iterations, grow_by, initial_max, find always false" do
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

    it "max_iterations, grow_by, initial_max, find sometimes true" do
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

  end

end
