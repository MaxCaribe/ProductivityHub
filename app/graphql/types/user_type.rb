# frozen_string_literal: true

class Types::UserType < Types::BaseObject
  field :id, ID, null: false
  field :name, String
end
