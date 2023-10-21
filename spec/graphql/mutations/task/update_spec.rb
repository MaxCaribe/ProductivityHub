# frozen_string_literal: true

require 'rails_helper'

describe 'Mutations::Task::Update', type: :request do
  describe '.resolve' do
    let(:created_task) { create(:task) }
    let(:user) { create(:user) }
    let(:task) { build(:task, user:) }

    it "doesn't change amount of task" do
      post '/graphql', params: { query: query(task_id: created_task.id, task:) }
      expect(Task.count).to eq(1)
    end

    it 'returns a task with updated data' do
      post '/graphql',  params: { query: query(task_id: created_task.id, task:) }
      json = JSON.parse(response.body)
      data = json['data']['taskUpdate']['task']

      expect(data).to include(
        'id' => created_task.id.to_s,
        'name' => task.name,
        'due' => task.due.to_s,
        'description' => task.description,
        'user' => { 'id' => user.id.to_s }
      )
    end

    it 'returns error if no task with provided id exist' do
      post '/graphql', params: { query: query(task_id: created_task.id + 1, task:) }
      json = JSON.parse(response.body)
      errors = json['errors']
      expect(errors).to be_present
    end
  end

  def query(task_id:, task:)
    <<~GQL
      mutation {
        taskUpdate(
          input: {
            id: #{task_id}
            taskInput: {
              name: "#{task.name}"
              due: "#{task.due.to_s}"
              description: "#{task.description}"
              userId: #{task.user_id}
            }
          }
        ) {
          task {
            id
            name
            due
            description
            user {
              id
            }
          }   
        }
      }
    GQL
  end
end
