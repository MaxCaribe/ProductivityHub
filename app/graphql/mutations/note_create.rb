# frozen_string_literal: true

module Mutations
  class NoteCreate < BaseMutation
    description "Creates a new note"

    field :note, Types::NoteType, null: false

    argument :note_input, Types::NoteInputType, required: true

    def resolve(note_input:)
      note = ::Note.new(**note_input)
      raise GraphQL::ExecutionError.new "Error creating note", extensions: note.errors.to_hash unless note.save

      { note: note }
    end
  end
end
