module Maskara
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      new_env = env
      if maskara_path? env['PATH_INFO']
        log "Maskara path: #{env['PATH_INFO']}"
        new_env = env.dup
        new_env['MASKARA_REQUEST'] = true
        new_env['REQUEST_URI'] = new_env['PATH_INFO'] = env['PATH_INFO'].sub(maskara_regex, '/')
        new_env['REQUEST_URI'] += "?#{env['QUERY_STRING']}" unless env['QUERY_STRING'].nil? || env['QUERY_STRING'].empty?
      end
      @app.call(new_env)
    end

    def maskara_path? path
      path =~ maskara_regex
    end

    def maskara_regex
      /\A(\/#{Maskara.path_stub}\/)/
    end

    def log msg
      if (defined? Rails)
        Rails.logger.debug msg
      else
        puts msg
      end
    end
  end
end
