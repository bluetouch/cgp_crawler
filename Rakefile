require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'

CONFIG_FILE = File.join(File.dirname(__FILE__), 'config', 'config.yml')
CONFIG = YAML.load_file(CONFIG_FILE)
CACHE_PATH = File.expand_path(File.join(File.dirname(__FILE__),
  CONFIG['cache_path']))

desc "crawl CGP records, save to #{CACHE_PATH}"
task :crawl do
  require File.dirname(__FILE__) + "/lib/crawler"
  crawler = Crawler.new(CACHE_PATH)
  crawler.run(:initial_max => 100, :grow_by => 100, :delay => 1)
end

desc "run all specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.spec_opts = ["--color"]
end
