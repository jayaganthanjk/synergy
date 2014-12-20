class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.integer :user_id
      t.integer :story_id
      t.text :content
      t.integer :priority
      t.string :state

      t.timestamps
    end
  end
end
