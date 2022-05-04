require 'faker'

FactoryBot.define do
  factory :book do
    title { Faker::Name.name }
    description { Faker::Lorem.sentence }
  end
end