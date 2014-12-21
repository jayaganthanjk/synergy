class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
