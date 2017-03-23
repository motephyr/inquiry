class AddNameAndSkillAndTool < ActiveRecord::Migration[5.0]
  def change
    add_column :user_infos, :name, :string
    add_column :user_infos, :skill_and_tool, :text
  end
end
