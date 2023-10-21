# frozen_string_literal: true

class Types::Input::NoteType < Types::BaseInputObject
  argument :name, String, required: true, validates: { allow_blank: false }
  argument :content, [String]
  argument :user_id, Integer, validates: { allow_null: false }
end

