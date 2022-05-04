require 'faker'

FactoryBot.define do
  factory :book do
    title { Faker::Name.name }
    description { Faker::Company.bs }
  end
end