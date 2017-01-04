# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Users
        extend ActiveSupport::Concern
        included do
          desc 'User login [POST /users/login]'
          params do
            requires :email,    type: String
            requires :password, type: String, length: 6..20
          end
          post '/users/login' do
            login = Login.find_by login_token: params.email
            if login.present? && login.valid_password?(params.password)
              wrap_meta(
                id: login.user.id,
                category: login.user.class.to_s.downcase,
                auth_token: login.auth_token
              )
            else
              bad_request!(I18n.t('app.api.password_mismatch'))
              return
            end
          end

          desc 'Reset password [POST /users/password]'
          params do
            optional :old_password, type: String
            requires :new_password, type: String, length: 6..20
          end
          post '/users/password' do
            authorize! :update_password, current_user
          end

          desc 'Send forget password request [POST /users/forget]'
          params do
            requires :target, type: String
          end
          post '/users/forget' do
          end

          desc 'Verify forget password request and reset password [POST /users/forget/verify]'
          params do
            requires :target, type: String
            requires :code, type: String, length: (6..6)
            requires :new_password, type: String, length: (6..20)
          end
          post '/users/forget/verify' do
          end
        end
      end
    end
  end
end
