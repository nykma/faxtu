# -*- coding: utf-8 -*-
require "rails_helper"

describe API::V1::Root do
  include ::Rack::Test::Methods
  def app
    API::V1::Root
  end

  describe 'User login [POST /users/login]' do
    context 'should return success' do
      it 'when user is an User' do
        password = Faker::Internet.password
        user = create(:user, password: password)
        login = user.logins.first

        post '/users/login', email: login.login_token, password: password
        _, body = extract_result
        expect(body).to eq(
          'id' => user.id,
          'category' => user.class.to_s.downcase,
          'auth_token' => login.auth_token
        )
      end

      it 'when user is an Admin' do
        password = Faker::Internet.password
        admin = create(:admin, password: password)
        login = admin.logins.first

        post '/users/login', email: login.login_token, password: password
        _, body = extract_result
        expect(body).to eq(
          'id' => admin.id,
          'category' => admin.class.to_s.downcase,
          'auth_token' => login.auth_token
        )
      end
    end

    context 'should return error' do
      it 'when password invalid' do
        password = Faker::Internet.password
        admin = create(:admin, password: password)
        login = admin.logins.first

        post '/users/login', email: login.login_token, password: Faker::Internet.password
        meta, = extract_result
        expect(meta['status']).to eq 3
        expect(meta['msg']).to eq(I18n.t('app.api.password_mismatch'))
      end

      it 'when email not found' do
        post '/users/login', email: Faker::Internet.email, password: Faker::Internet.password
        meta, = extract_result
        expect(meta['status']).to eq 3
        expect(meta['msg']).to eq(I18n.t('app.api.password_mismatch'))
      end
    end
  end
end
