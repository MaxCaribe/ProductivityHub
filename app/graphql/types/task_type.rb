# frozen_string_literal: true

module Types
  class TaskType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String
    field :due, GraphQL::Types::ISO8601Date
    field :user_id, Integer
  end
end
