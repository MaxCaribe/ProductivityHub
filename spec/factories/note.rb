# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :note do
    name { Faker::Book.title }
    content { [Faker::ChuckNorris.fact, Faker::ChuckNorris.fact, Faker::ChuckNorris.fact] }
    user { build(:user) }
  end
end

