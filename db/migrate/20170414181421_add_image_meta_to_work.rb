class AddImageMetaToWork < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :image_meta, :jsonb, default: {}, null: false
  end
end
