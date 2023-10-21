# frozen_string_literal: true

require 'rails_helper'

describe 'Mutations::Note::Create', type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:note) { build(:note, user:) }

    it 'creates a note' do
      expect do
        post '/graphql', params: { query: query(note:) }
      end.to change { Note.count }.by(1)
    end

    it 'returns a note' do
      post '/graphql',  params: { query: query(note:) }
      json = JSON.parse(response.body)
      data = json['data']['noteCreate']['note']

      expect(data).to include(
        'id' => be_present,
        'name' => note.name,
        'content' => note.content,
        'user' => { 'id' => user.id.to_s }
      )
    end

    it 'returns error if name is not provided' do
      note.name = nil
      post '/graphql', params: { query: query(note: note) }
      json = JSON.parse(response.body)
      errors = json['errors']
      expect(errors).to be_present
    end
  end

  def query(note:)
    <<~GQL
      mutation {
        noteCreate(
          input: { 
            noteInput: {
              name: "#{note.name}"
              content: #{note.content}
              userId: #{note.user_id}
            }
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
