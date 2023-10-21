# frozen_string_literal: true

require 'rails_helper'

describe 'Types::QueryType', type: :request do
  describe '.note' do
    query = <<~GQL
      query($id: ID!) {
        note(id: $id) {
          id
          name
          content
          user {
            id
          }
        }
      }
    GQL
    let!(:note) { create(:note) }

    it 'shows note' do
      post '/graphql',  params: { query: query, variables: { id: note.id } }
      json = JSON.parse(response.body)
      expect(json['data']['note']['id']).to eq(note.id.to_s)
    end
  end

  describe '.notes' do
    query = <<~GQL
      query {
        notes {
          id
          name
          content
          user {
            id
          }
        }
      }
    GQL

    before { 3.times { create(:note) } }

    it 'shows all notes' do
      post '/graphql',  params: { query: query }
      json = JSON.parse(response.body)
      expect(json['data']['notes'].size).to eq(3)
    end
  end
end