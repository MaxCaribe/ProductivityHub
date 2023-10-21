# frozen_string_literal: true

class Mutations::Task::Delete < Mutations::BaseMutation
  description "Deletes a task by ID"

  field :task, Types::TaskType, null: false

  argument :id, ID, required: true

  def resolve(id:)
    task = ::Task.find_by(id: id)
    raise GraphQL::ExecutionError.new "Task with id \"#{id}\" doesn't exist" unless task
    raise GraphQL::ExecutionError.new "Error deleting task", extensions: task.errors.to_hash unless task.destroy

    { task: task }
  end
end
