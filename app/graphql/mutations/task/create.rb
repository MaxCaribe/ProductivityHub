# frozen_string_literal: true

class Mutations::Task::Create < Mutations::BaseMutation
  description "Creates a new task"

  field :task, Types::TaskType, null: false

  argument :task_input, Types::Input::TaskType, required: true

  def resolve(task_input:)
    task = Task.new(**task_input)
    raise GraphQL::ExecutionError.new "Error creating task", extensions: task.errors.to_hash unless task.save

    { task: task }
  end
end
