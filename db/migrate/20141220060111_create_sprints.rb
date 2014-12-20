class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.string :name
      t.integer :project_id
      t.string :state
      t.datetime :start
      t.datetime :end
      t.boolean :archive, default: false

      t.timestamps
    end
  end
end
