class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :name
      t.text :description
      t.integer :sprint_id
      t.integer :project_id
      t.string :state
      t.datetime :due_date
      t.boolean :archive, default: false

      t.timestamps
    end
  end
end
