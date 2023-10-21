# frozen_string_literal: true

class Types::MutationType < Types::BaseObject
  field :note_delete, mutation: Mutations::Note::Delete
  field :note_update, mutation: Mutations::Note::Update
  field :note_create, mutation: Mutations::Note::Create
  field :task_delete, mutation: Mutations::Task::Delete
  field :task_update, mutation: Mutations::Task::Update
  field :task_create, mutation: Mutations::Task::Create
end
