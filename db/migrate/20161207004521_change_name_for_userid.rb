class ChangeNameForUserid < ActiveRecord::Migration
  def change
    rename_column :surveys, :user_id, :researcher_id
  end
end
