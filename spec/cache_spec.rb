require File.dirname(__FILE__) + "/spec_helper"
require File.expand_path(File.dirname(__FILE__) + "/../lib/cache")

describe Cache do

  before do
    @base_path = File.expand_path(File.join(File.dirname(__FILE__),
      '..', 'tmp', 'cache'))
    @cache = Cache.new(@base_path)
    FileUtils.rm_rf(@base_path)
    filenames_and_content = {
      "#{@base_path}/001/110/001110555-000.xml" => "001110555-000",
      "#{@base_path}/002/220/002220777-000.xml" => "002220777-000",
      "#{@base_path}/002/220/002220777-001.xml" => "002220777-001",
      "#{@base_path}/002/220/002220777-002.xml" => "002220777-002",
    }
    filenames_and_content.each do |filename, content|
      dir = File.dirname(filename)
      FileUtils.mkdir_p(dir) unless File.exist?(dir)
      File.open(filename, "w") { |f| f.write(content) }
    end
  end

  describe "pathname" do
    it "should work" do
      @cache.pathname(333_444, 4).should == File.join(@base_path,
        '000', '333', '000333444-004.xml')
    end
  end

  describe "find" do
    it "true positive, example 1" do
      @cache.find(1_110_555).should == "001110555-000"
    end
    
    it "true positive, example 2" do
      @cache.find(2_220_777).should == "002220777-002"
    end

    it "true negative" do
      @cache.find(1_110_556).should == nil
    end
  end

  describe "latest_revision" do
    it "true positive, example 1" do
      @cache.latest_revision(1_110_555).should == 0
    end

    it "true positive, example 2" do
      @cache.latest_revision(2_220_777).should == 2
    end

    it "true negative" do
      @cache.latest_revision(1_110_556).should == nil
    end
  end

  describe "latest_pathname" do
    it "true positive, example 1" do
      @cache.latest_pathname(1_110_555).should ==
        "#{@base_path}/001/110/001110555-000.xml"
    end

    it "true positive, example 2" do
      @cache.latest_pathname(2_220_777).should ==
        "#{@base_path}/002/220/002220777-002.xml"
    end

    it "true negative" do
      @cache.latest_pathname(1_110_556).should == nil
    end
  end

  describe "save" do
    it "new content, new # should work" do
      @cache.save("003330999-000", 3_330_999)
      File.read("#{@base_path}/003/330/003330999-000.xml").should ==
        "003330999-000"
    end

    it "new content, existing # should work" do
      @cache.save("002220777-003", 2_220_777)
      File.read("#{@base_path}/002/220/002220777-003.xml").should ==
        "002220777-003"
    end

    it "same content, existing # should work" do
      time = File.mtime("#{@base_path}/002/220/002220777-002.xml")
      @cache.save("002220777-002", 2_220_777)
      File.exist?("#{@base_path}/002/220/002220777-003.xml").should be_false
      File.read("#{@base_path}/002/220/002220777-002.xml").should ==
        "002220777-002"
      File.mtime("#{@base_path}/002/220/002220777-002.xml").should == time
    end
  end

  describe "save_new_revision" do
    it "new content, new # should work" do
      @cache.save_new_revision("003330999-000", 3_330_999)
      File.read("#{@base_path}/003/330/003330999-000.xml").should ==
        "003330999-000"
    end

    it "new content, existing # should work" do
      @cache.save_new_revision("002220777-003", 2_220_777)
      File.read("#{@base_path}/002/220/002220777-003.xml").should ==
        "002220777-003"
    end
  end

end
