# -*- coding: utf-8 -*-
module API
  class Root < Grape::API
    def self.inherited(subclass)
      super

      subclass.instance_eval do
        helpers API::Helper
        format :json

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          rack_response({ meta: { status: 3, msg: e.message }, body: {} }.to_json, 200)
        end
        rescue_from ActiveRecord::RecordInvalid do |e|
          errors = e.record.errors.messages.values
          rack_response({ meta: { status: 3, msg: errors.join(', ') }, body: {} }.to_json, 200)
        end
        rescue_from ActiveRecord::RecordNotFound do |e|
          rack_response({ meta: { status: 3, msg: e.message }, body: {} }.to_json, 200)
        end
        rescue_from CanCan::AccessDenied do
          rack_response({
            meta: {
              status: 2,
              msg: I18n.t('api.auth.unauthorized')
            }, body: {}
          }.to_json, 200)
        end

        rescue_from :all do
          rack_response({ meta: { status: 99, msg: 'Internal Server Error' }, body: {} }.to_json, 200)
        end
      end
    end
  end
end

class Length < Grape::Validations::Base
  def validate_param!(attr_name, params)
    if @option.is_a?(Integer) && params[attr_name].length > @option
      raise Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "不能超过 #{@option} 个字符"
    elsif @option.is_a?(Range) && !(params[attr_name].respond_to?(:length) && @option.include?(params[attr_name].length))
      if @option.min == @option.max
        if @option.min == 1
          raise Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: '必须填写'
        else
          raise Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "必须为 #{@option.min} 个字符"
        end
      else
        raise Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "必须在 #{@option.min} 到 #{@option.max} 个字符内"
      end
    end
  end
end
