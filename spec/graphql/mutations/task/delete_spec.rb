# frozen_string_literal: true

require 'rails_helper'

describe 'Mutations::Task::Delete', type: :request do
  describe '.resolve' do
    let(:task) { create(:task) }

    it 'deletes a task' do
      post '/graphql', params: { query: query(task_id: task.id) }

      expect(Task.count).to eq(0)
    end

    it 'returns a task' do
      post '/graphql',  params: { query: query(task_id: task.id) }
      json = JSON.parse(response.body)
      data = json['data']['taskDelete']['task']

      expect(data).to include(
        'id' => task.id.to_s,
        'name' => task.name,
        'due' => task.due.to_s,
        'description' => task.description,
        'user' => { 'id' => task.user.id.to_s }
      )
    end

    it 'returns error if no task with provided id exist' do
      post '/graphql', params: { query: query(task_id: task.id + 1) }
      json = JSON.parse(response.body)
      errors = json['errors']
      expect(errors).to be_present
    end
  end

  def query(task_id:)
    <<~GQL
      mutation {
        taskDelete(
          input: { 
            id: "#{task_id}"
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
