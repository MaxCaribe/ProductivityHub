# frozen_string_literal: true

require 'rails_helper'

describe 'Mutations::Note::Delete', type: :request do
  describe '.resolve' do
    let(:note) { create(:note) }

    it 'deletes a note' do
      post '/graphql', params: { query: query(note_id: note.id) }

      expect(Note.count).to eq(0)
    end

    it 'returns a note' do
      post '/graphql',  params: { query: query(note_id: note.id) }
      json = JSON.parse(response.body)
      data = json['data']['noteDelete']['note']

      expect(data).to include(
        'id' => note.id.to_s,
        'name' => note.name,
        'content' => note.content,
        'user' => { 'id' => note.user.id.to_s }
      )
    end

    it 'returns error if no note with provided id exist' do
      post '/graphql', params: { query: query(note_id: note.id + 1) }
      json = JSON.parse(response.body)
      errors = json['errors']
      expect(errors).to be_present
    end
  end

  def query(note_id:)
    <<~GQL
      mutation {
        noteDelete(
          input: { 
            id: "#{note_id}"
          }
        ) {
          note {
            id
            name
            content
            user {
              id
            }
          }   
        }
      }
    GQL
  end
end
