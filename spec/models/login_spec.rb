require 'rails_helper'

RSpec.describe Login, type: :model do
  describe 'validations' do
    it { should validate_presence_of :login_token }
    it { should validate_presence_of :login_secret }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :user_type }
    it { should validate_uniqueness_of(:login_token).ignoring_case_sensitivity }
  end

  describe 'associations' do
    it { should belong_to :user }
  end

  describe 'after_initialize' do
    it 'should generate auth token' do
      expect(create(:login).auth_token).to be_a String
    end

    it 'should not refresh auth token when it existed' do
      login = create(:login)
      old_token = login.auth_token
      expect(Login.first.auth_token).to eq old_token
    end
  end
end
