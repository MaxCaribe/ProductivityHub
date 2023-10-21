# frozen_string_literal: true

require 'rails_helper'

describe 'Mutations::Task::Create', type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:task) { build(:task, user:) }

    it 'creates a task' do
      expect do
        post '/graphql', params: { query: query(task:) }
      end.to change { Task.count }.by(1)
    end

    it 'returns a task' do
      post '/graphql',  params: { query: query(task:) }
      json = JSON.parse(response.body)
      data = json['data']['taskCreate']['task']

      expect(data).to include(
        'id' => be_present,
        'name' => task.name,
        'due' => task.due.to_s,
        'description' => task.description,
        'user' => { 'id' => user.id.to_s }
      )
    end

    it 'returns error if name is not provided' do
      task.name = nil
      post '/graphql', params: { query: query(task: task) }
      json = JSON.parse(response.body)
      errors = json['errors']
      expect(errors).to be_present
    end
  end

  def query(task:)
    <<~GQL
      mutation {
        taskCreate(
          input: { 
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
