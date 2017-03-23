class AddUserInfoMissingIndexes < ActiveRecord::Migration
  def change
    add_index :user_surveys, :category_id
    add_index :user_infos, :category_id
    add_index :user_infos, :user_id
    add_index :categories, :parent_id
  end
end
