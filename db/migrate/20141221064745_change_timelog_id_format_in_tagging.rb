class ChangeTimelogIdFormatInTagging < ActiveRecord::Migration
  def change
    rename_column :taggings, :timelog_id, :duration
    add_column :taggings, :user_id, :integer
  end
end
