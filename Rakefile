require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'
require File.dirname(__FILE__) + '/lib/config'

CONFIG = Cgp::Config.new

desc "crawl CGP records, save to #{CONFIG.cache_path}"
task :crawl do
  require File.dirname(__FILE__) + "/lib/crawler"
  crawler = Cgp::Crawler.new(CONFIG.cache_path)
  crawler.run({
    :start_at    => CONFIG.start_at,
    :min         => CONFIG.min,
    :initial_max => CONFIG.initial_max,
    :grow_by     => CONFIG.grow_by,
    :delay       => CONFIG.delay,
  })
end

BULK_DATA_README = File.join(CONFIG.cache_path, 'README.html')

desc "Generate #{BULK_DATA_README}"
task :readme do
  require 'rdiscount'
  input_filename = File.dirname(__FILE__) + '/doc/bulk_data.markdown'
  markdown = RDiscount.new(File.read(input_filename))
  File.open(BULK_DATA_README, "w") { |f| f.write(markdown.to_html) }
end

desc "run all specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.spec_opts = ["--color"]
end
