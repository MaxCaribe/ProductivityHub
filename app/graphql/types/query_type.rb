# frozen_string_literal: true

class Types::QueryType < Types::BaseObject
  field :task, Types::TaskType, null: false, description: "Fetches the task by ID." do
    argument :id, ID, required: true, description: "ID of the task."
  end

  def task(id:)
    Task.find(id)
  end

  field :tasks, [Types::TaskType], null: false, description: "Fetches all task."

  def tasks
    Task.all
  end

  field :note, Types::NoteType, null: false, description: "Fetches the note by ID." do
    argument :id, ID, required: true, description: "ID of the note."
  end

  def note(id:)
    Note.find(id)
  end

  field :notes, [Types::NoteType], null: false, description: "Fetches all note."

  def notes
    Note.all
  end
end
