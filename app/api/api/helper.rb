module API
  module Helper
    def current_user
      return @current_user if @current_user

      @current_user = Agent.find_by(authentication_token: headers['Authorization']) || Admin.find_by(authentication_token: headers['Authorization'])
      state_error! unless @current_user
      @current_user
    end

    def set_meta(code = 0, message = 'OK')
      status 200

      real_message = message
      real_message = message.join("\n") if message.respond_to?(:join)

      result = {}
      result[:meta] = { status: code.to_i, msg: real_message, err: real_message }
      result[:body] = case @body
                      when Hash then @body
                      else @body.as_json || {}
                      end
      @body = result
    end

    def wrap_meta(result, message = 'OK', code = 0)
      status(200)
      result ||= {}

      real_message = message
      real_message = message.join('\n') if message.respond_to?(:join)

      ret = {}
      ret[:body] = result
      ret[:meta] = { status: code.to_i, msg: real_message, err: real_message }

      ret
    end

    def state_error!(info = I18n.t('api.auth.state_error'))
      render_api_error! set_meta(1, info)
    end

    def unauthorized!(info = I18n.t("api.auth.unauthorized"))
      render_api_error! set_meta(2, info)
    end

    def bad_request!(message)
      render_api_error!(set_meta(3, message))
    end

    def info!(message)
      render_api_error!(set_meta(4, message))
    end

    def render_api_error!(message)
      error!(message, 200)
    end

    def present(*)
      super
      set_meta
    end
  end
end
