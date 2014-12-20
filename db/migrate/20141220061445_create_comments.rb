class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :content
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end
end
