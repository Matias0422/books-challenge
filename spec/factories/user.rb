require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :reader do
      after(:create) do |user|
        user.add_role( UserRole::READER )
      end
    end

    trait :librarian do
      after(:create) do |user|
        user.add_role( UserRole::LIBRARIAN )
      end
    end
  end
end
