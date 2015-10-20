class Maskara::Data
  class << self
    def data_file
      Maskara.configuration.data_file
    end

    def data
      @data ||= load_data
    end

    def load_data
      begin
        return YAML.load(open(data_file).read)
      rescue Errno::ENOENT
      rescue Psych::SyntaxError
        puts "Invalid YAML found in Maskara data file at #{data_file}"
      end
      {}
    end

    def controllers_data
      data.fetch('controllers', {})
    end

    def controller_data(controller)
      controllers_data.fetch(controller, {})
    end

    def action_data(action, controller)
      controller_data(controller).fetch('actions', {}).fetch(action, {})
    end

    def skip_filters
      controllers_data.collect do |controller, config|
        unless config['skip_filters'].blank?
          ["#{controller.classify}Controller".constantize, config['skip_filters'].map(&:to_sym)]
        end
      end.compact
    end
  end
end
