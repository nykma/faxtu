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
end
