# frozen_string_literal: true

module Mutations
  class NoteUpdate < BaseMutation
    description "Updates a note by id"

    field :note, Types::NoteType, null: false

    argument :id, ID, required: true
    argument :note_input, Types::NoteInputType, required: true

    def resolve(id:, note_input:)
      note = ::Note.find(id)
      raise GraphQL::ExecutionError.new "Error updating note", extensions: note.errors.to_hash unless note.update(**note_input)

      { note: note }
    end
  end
end
