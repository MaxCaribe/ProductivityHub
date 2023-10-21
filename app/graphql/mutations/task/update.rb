# frozen_string_literal: true

class Mutations::Task::Update < Mutations::BaseMutation
  description "Updates a task by id"

  field :task, Types::TaskType, null: false

  argument :id, ID, required: true
  argument :task_input, Types::Input::TaskType, required: true

  def resolve(id:, task_input:)
    task = ::Task.find_by(id: id)
    raise GraphQL::ExecutionError.new "Task with id \"#{id}\" doesn't exist" unless task
    raise GraphQL::ExecutionError.new "Error updating task", extensions: task.errors.to_hash unless task.update(**task_input)

    { task: task }
  end
end
