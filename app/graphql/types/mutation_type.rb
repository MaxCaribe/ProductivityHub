# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :note_delete, mutation: Mutations::NoteDelete
    field :note_update, mutation: Mutations::NoteUpdate
    field :note_create, mutation: Mutations::NoteCreate
    field :task_delete, mutation: Mutations::TaskDelete
    field :task_update, mutation: Mutations::TaskUpdate
    field :task_create, mutation: Mutations::TaskCreate
  end
end
