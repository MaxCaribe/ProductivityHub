# frozen_string_literal: true

class Types::NoteType < Types::BaseObject
  field :id, ID, null: false
  field :name, String, null: false
  field :content, [String]
  field :user, Types::UserType
end
