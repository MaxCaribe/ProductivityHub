# frozen_string_literal: true

class Mutations::Note::Create < Mutations::BaseMutation
  description "Creates a new note"

  field :note, Types::NoteType, null: false

  argument :note_input, Types::Input::NoteType, required: true

  def resolve(note_input:)
    note = Note.new(**note_input)
    raise GraphQL::ExecutionError.new "Error creating note", extensions: note.errors.to_hash unless note.save

    { note: note }
  end
end
