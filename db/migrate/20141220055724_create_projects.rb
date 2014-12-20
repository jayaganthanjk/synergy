class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :state
      t.datetime :start
      t.datetime :end
      t.boolean :archive, default: false

      t.timestamps
    end
  end
end
