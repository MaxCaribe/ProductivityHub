# frozen_string_literal: true

module Types
  class NoteType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :content, String
    field :user_id, Integer
  end
end
