# frozen_string_literal: true

class Types::Input::TaskType < Types::BaseInputObject
  argument :name, String, required: true, validates: { allow_blank: false }
  argument :due, GraphQL::Types::ISO8601Date
  argument :description, String
  argument :user_id, Integer, validates: { allow_null: false }
end

