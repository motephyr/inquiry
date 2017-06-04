class AddCategoryIdToWorks < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :category_id, :integer
    add_index :works, :category_id
  end
end
