require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'
require File.dirname(__FILE__) + '/lib/config'

CONFIG = Cgp::Config.new

desc "crawl CGP records, save to #{CONFIG.cache_path}"
task :crawl do
  require File.dirname(__FILE__) + "/lib/crawler"
  crawler = Cgp::Crawler.new(CONFIG.cache_path)
  crawler.run(:initial_max => 100, :grow_by => 100, :delay => 1)
end

desc "run all specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.spec_opts = ["--color"]
end
