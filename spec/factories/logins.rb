FactoryGirl.define do
  factory :login do
    login_token { Faker::Internet.email }
    login_secret { Faker::Internet.password }

    before(:create) do |login, _evaluator|
      login.user = create(:user, no_login: true) if login.user.blank?
    end
  end
end
