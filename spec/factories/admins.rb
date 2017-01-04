FactoryGirl.define do
  factory :admin do
    transient do
      password { Faker::Internet.password }
    end

    name { Faker::Name.name }

    after(:create) do |admin, evaluator|
      create(:login, user: admin, password: evaluator.password)
    end
  end
end
