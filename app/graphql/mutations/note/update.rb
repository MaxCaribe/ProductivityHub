# frozen_string_literal: true

class Mutations::Note::Update < Mutations::BaseMutation
  description "Updates a note by id"

  field :note, Types::NoteType, null: false

  argument :id, ID, required: true
  argument :note_input, Types::Input::NoteType, required: true

  def resolve(id:, note_input:)
    note = ::Note.find_by(id: id)
    raise GraphQL::ExecutionError.new "Note with id \"#{id}\" doesn't exist" unless note
    raise GraphQL::ExecutionError.new "Error updating note", extensions: note.errors.to_hash unless note.update(**note_input)

    { note: note }
  end
end
