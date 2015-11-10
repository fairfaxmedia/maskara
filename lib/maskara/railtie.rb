require 'recursive-open-struct'
require 'maskara/generator'
require 'maskara/data'

# Support adding /maskara into generated routes
if Rails::VERSION::MAJOR >= 4
  module ActionDispatch::Routing
    class RouteSet::NamedRouteCollection::UrlHelper::OptimizedUrlHelper
      alias_method :call_without_maskara_check, :call

      def call(t, args, inner_options)
        maskara_prefix(t.controller) + call_without_maskara_check(t, args, inner_options)
      end

      def maskara_prefix(controller)
        controller.maskara_request? ? "/#{Maskara.path_stub}" : ''
      end
    end
  end
end

# Populate controllers with instance variables for maskara requests
class AbstractController::Base
  alias_method :process_action_without_maskara_check, :process_action

  def process_action(method_name, *args)
    if request.env['MASKARA_REQUEST']
      maskara_populate_data(method_name)
      render
    else
      process_action_without_maskara_check(method_name, *args)
    end
  end

  def maskara_request?
    request.env['MASKARA_REQUEST'] == true
  end

  def maskara_populate_data(action)
    Maskara::Data.action_data(action, controller_path).each do |key, data|
      instance_variable_set("@#{key}", maskara_presentable_data(data))
    end
  end

  def maskara_presentable_data(data)
    RecursiveOpenStruct.new(data, :recurse_over_arrays => true)
  end
end

# Initialise maskara and disabled filters
module Maskara
  class Railtie < Rails::Railtie
    initializer "maskara_railtie.configure_rails_initialization" do
      Maskara.configure do |config|
        config.data_path = Rails.root.join('db', 'fixtures')
      end

      Maskara::Data.skip_filters.each do |klass, filters|
        filters.each { |filter| klass.skip_filter filter, if: :maskara_request? }
      end
    end

    rake_tasks do
      load 'maskara/tasks.rake'
    end
  end
end
