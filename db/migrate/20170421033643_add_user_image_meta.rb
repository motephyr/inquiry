class AddUserImageMeta < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :image, :string
    add_column :users, :image_meta, :jsonb, default: {}, null: false
  end
end
