class FixCategory < ActiveRecord::Migration[5.0]
  def change
    change_column :categories, :title, :string
  end
end
