module Cgp
  class Config

    ROOT_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))

    attr_reader :file
    attr_reader :start_at
    attr_reader :min
    attr_reader :initial_max
    attr_reader :grow_by
    attr_reader :delay
    attr_reader :cache_path

    def initialize
      @file = File.join(ROOT_DIR, 'config', 'config.yml')
      @data = begin
        YAML.load_file(@file)
      rescue Errno::ENOENT
        raise "configuration file not found: #{@file}"
      end
      @start_at    = lookup('start_at',    Integer)
      @min         = lookup('min',         Integer)
      @initial_max = lookup('initial_max', Integer)
      @grow_by     = lookup('grow_by',     Integer)
      @delay       = lookup('delay',       Numeric)
      _cache_path  = lookup('cache_path',  String)
      @cache_path  = File.expand_path(File.join(ROOT_DIR, _cache_path))
    end

    protected

    def lookup(key, klass)
      value = @data[key]
      raise "#{key} not specified in #{@file}" unless value
      raise "#{key} not a/an #{klass}" unless value.is_a?(klass)
      value
    end

  end
end
