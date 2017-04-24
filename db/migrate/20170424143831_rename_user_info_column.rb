class RenameUserInfoColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :user_infos, :skill_and_tool, :skill_tool
  end
end
