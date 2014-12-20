class CreateTimelogs < ActiveRecord::Migration
  def change
    create_table :timelogs do |t|
      t.datetime :date
      t.float :duration
      t.integer :user_id
      t.integer :tag_id
      t.text :description
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end
end
