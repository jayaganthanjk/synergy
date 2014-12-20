class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :project_id
      t.integer :story_id
      t.string :state
      t.datetime :due_date
      t.integer :user_id
      t.float :estimated_time
      t.boolean :archive, default: false

      t.timestamps
    end
  end
end
