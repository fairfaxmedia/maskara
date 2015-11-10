require "maskara/data"
require "maskara/middleware"
require "maskara/version"

require 'maskara/railtie' if defined?(Rails)

module Maskara
  class Configuration
    attr_accessor :data_path

    def data_path
      @data_path or fail NotConfiguredError.new("Maskara needs to be configured with a data_path to find #{data_file_name}")
    end

    def data_file
      File.join(data_path, data_file_name)
    end

    def data_file_name
      'maskara.yml'
    end
  end
  
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    def path_stub
      'maskara'
    end
  end

  class NotConfiguredError < StandardError; end
end
