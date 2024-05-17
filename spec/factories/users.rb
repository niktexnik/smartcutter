FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.first_name }
    middlename { Faker::Name.middle_name }
    surname { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
    agreement { true }
  end
end
