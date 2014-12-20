class CreateRoleLists < ActiveRecord::Migration
  def change
    create_table :role_lists do |t|
      t.string :name, unique: true

      t.timestamps
    end
  end
end
