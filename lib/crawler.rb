require File.dirname(__FILE__) + "/connection"
require File.dirname(__FILE__) + "/utility"
require File.dirname(__FILE__) + "/cache"

class Crawler

  def initialize(cache_path)
    @connection = Connection.new
    @cache = Cache.new(cache_path)
  end

  def run(options = {})
    options[:initial_max] ||= 100
    options[:grow_by]     ||= 100
    quiet = options.delete(:quiet)
    delay = options.delete(:delay) || 1
    Utility.cycle(options) do |system_num|
      sleep(delay)
      record = @connection.find_by_system_number(system_num)
      xml = self.class.record_to_xml(record)
      puts "%09i %s" % [system_num, record ? "+" : "-"] unless quiet
      @cache.save(xml, system_num)
      record
    end
  end

  def self.record_to_xml(record)
    if record
      # Converts from MARC-8. Saves to UTF-8 format.
      record.xml("marc8", "utf8") 
    else
      ""
    end
  end

end
