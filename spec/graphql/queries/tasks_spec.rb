# frozen_string_literal: true

require 'rails_helper'

describe 'Types::QueryType', type: :request do
  describe '.task' do
    query = <<~GQL
      query($id: ID!) {
        task(id: $id) {
          id
          name
          due
          description
          user {
            id
          }
        }
      }
    GQL
    let!(:task) { create(:task) }

    it 'shows task' do
      post '/graphql',  params: { query: query, variables: { id: task.id } }
      json = JSON.parse(response.body)
      expect(json['data']['task']['id']).to eq(task.id.to_s)
    end
  end

  describe '.tasks' do
    query = <<~GQL
      query {
        tasks {
          id
          name
          due
          description
          user {
            id
          }
        }
      }
    GQL

    before { 3.times { create(:task) } }

    it 'shows all tasks' do
      post '/graphql',  params: { query: query }
      json = JSON.parse(response.body)
      expect(json['data']['tasks'].size).to eq(3)
    end
  end
end