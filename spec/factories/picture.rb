require 'faker'

FactoryBot.define do
  factory :picture do
    url { Faker::Internet.url }
  end
end