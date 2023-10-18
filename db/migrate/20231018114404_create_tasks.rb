class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description
      t.date :due
      t.belongs_to :user

      t.timestamps
    end
  end
end
