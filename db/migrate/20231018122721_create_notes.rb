class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :name, null: false
      t.string :content, array: true
      t.belongs_to :user

      t.timestamps
    end
  end
end
