# frozen_string_literal: true

module Mutations
  class TaskDelete < BaseMutation
    description "Deletes a task by ID"

    field :task, Types::TaskType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      task = ::Task.find(id)
      raise GraphQL::ExecutionError.new "Error deleting task", extensions: task.errors.to_hash unless task.destroy

      { task: task }
    end
  end
end
