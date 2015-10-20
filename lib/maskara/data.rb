class Maskara::Data
  class << self
    def data
      @data ||= YAML.load_file(Maskara.configuration.data_file) || {}
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
