# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :task do
    name { Faker::Company.name }
    due { Faker::Date.forward(from: Date.tomorrow) } # by default we want 'due' to be in future
    description { Faker::Company.catch_phrase }
    user { build(:user) }
  end
end