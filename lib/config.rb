module Cgp
  class Config

    ROOT_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))

    attr_accessor :file
    attr_accessor :cache_path
  
    def initialize
      @file = File.join(ROOT_DIR, 'config', 'config.yml')
      @data = begin
        YAML.load_file(@file)
      rescue Errno::ENOENT
        raise "configuration file not found: #{@file}"
      end
      @cache_path = if @data['cache_path'].empty?
        raise "cache_path not specified in #{@file}"
      else
        File.expand_path(File.join(ROOT_DIR, @data['cache_path']))
      end
    end

  end
end
