FactoryGirl.define do
  factory :user do
    transient do
      password { Faker::Internet.password }
      no_login false
    end

    name { Faker::Name.name }
    gender { [0, 1, 2].sample }

    after(:create) do |user, evaluator|
      create(:login, user: user, password: evaluator.password) unless evaluator.no_login
    end
  end
end
