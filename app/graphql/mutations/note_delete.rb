# frozen_string_literal: true

module Mutations
  class NoteDelete < BaseMutation
    description "Deletes a note by ID"

    field :note, Types::NoteType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      note = ::Note.find(id)
      raise GraphQL::ExecutionError.new "Error deleting note", extensions: note.errors.to_hash unless note.destroy

      { note: note }
    end
  end
end
