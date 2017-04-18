class AddStateAndfeaturedToWork < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :is_featured, :boolean, default: false
    add_column :works, :is_published, :boolean, default: true

    add_index :works, :is_featured
    add_index :works, :is_published
  end
end
