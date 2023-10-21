# frozen_string_literal: true

require 'rails_helper'

describe 'Mutations::Note::Update', type: :request do
  describe '.resolve' do
    let(:created_note) { create(:note) }
    let(:user) { create(:user) }
    let(:note) { build(:note, user:) }

    it "doesn't change amount of note" do
      post '/graphql', params: { query: query(note_id: created_note.id, note:) }
      expect(Note.count).to eq(1)
    end

    it 'returns a note with updated data' do
      post '/graphql',  params: { query: query(note_id: created_note.id, note:) }
      json = JSON.parse(response.body)
      data = json['data']['noteUpdate']['note']

      expect(data).to include(
        'id' => created_note.id.to_s,
        'name' => note.name,
        'content' => note.content,
        'user' => { 'id' => user.id.to_s }
      )
    end

    it 'returns error if no note with provided id exist' do
      post '/graphql', params: { query: query(note_id: created_note.id + 1, note:) }
      json = JSON.parse(response.body)
      errors = json['errors']
      expect(errors).to be_present
    end
  end

  def query(note_id:, note:)
    <<~GQL
      mutation {
        noteUpdate(
          input: {
            id: #{note_id}
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
