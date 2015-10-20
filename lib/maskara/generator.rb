class Maskara::Generator
  class << self
    def run
      fail("#{data_file} already exists.") if File.exists?(data_file)

      # In development Rails doesn't load controllers until they're referenced
      eager_load_controllers
      write_example_data_file
    end

    private

    def data_file
      Maskara.configuration.data_file
    end

    def write_example_data_file
      FileUtils.mkdir_p(Maskara.configuration.data_path)

      File.open(data_file, 'w') do |file|
        YAML.dump(clean_controller_data, file)
      end
    end

    def clean_controller_data
      { controllers: dump_controllers }.deep_stringify_keys
    end

    def dump_controllers
      Hash[ controller_list ]
    end

    def controller_list
      ActionController::Base.descendants.collect do |controller|
        catch(:empty_controller) do
          [ controller.controller_path, action_data(controller) ]
        end
      end.compact
    end

    def action_data(controller)
       { actions: Hash[ action_list(controller) ] }
    end

    def action_list(controller)
      throw :empty_controller if controller.action_methods.empty?

      controller.action_methods.to_a.collect{ |action| [ action, {} ] }
    end

    def eager_load_controllers
      Dir.glob(Rails.root.join "app/controllers/**/*_controller.rb").each do |file|
        require_dependency file
      end
    end
  end
end
