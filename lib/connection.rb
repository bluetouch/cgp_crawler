require 'rubygems'
require 'zoom'

module Cgp
  class Connection

    def initialize
      path = File.expand_path(File.dirname(__FILE__) + "/../config/access.yml")
      begin
        access = YAML::load_file(path)
      rescue
        raise "Access configuration file not found: #{CONFIG_FILE}"
      end
      @connection = ZOOM::Connection.new
      @connection.database_name = access['database']
      @connection.user          = access['username']
      @connection.password      = access['password']
      @connection.connect(access['address'], access['port'])
      @connection.preferred_record_syntax = 'USMARC'
    end

    def search(query, options = {})
      quiet = options[:quiet] || false
      puts "query : #{query}" unless quiet
      @connection.search(query)
    end

    # "System Number" is identified by 12
    # http://catalog.gpo.gov/F/?func=file&file_name=find-z3950
    def find_by_system_number(system_num)
      records = search("@attr 1=12 #{system_num}", :quiet => true)
      case records.length
      when 0 then nil
      when 1 then records[0]
      else raise "Multiple matches found"
      end
    end

  end
end
