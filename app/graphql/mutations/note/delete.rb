# frozen_string_literal: true

class Mutations::Note::Delete < Mutations::BaseMutation
  description "Deletes a note by ID"

  field :note, Types::NoteType, null: false

  argument :id, ID, required: true

  def resolve(id:)
    note = ::Note.find_by(id: id)
    raise GraphQL::ExecutionError.new "Note with id \"#{id}\" doesn't exist" unless note
    raise GraphQL::ExecutionError.new "Error deleting note", extensions: note.errors.to_hash unless note.destroy

    { note: note }
  end
end
