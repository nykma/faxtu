FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    gender { [0, 1, 2].sample }
  end
end
