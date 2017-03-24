class CreateCares < ActiveRecord::Migration[5.0]
  def change
    create_table :cares do |t|
      t.references :careable, polymorphic: true, index: true
      t.integer :user_id

      t.timestamps
    end
    add_index :cares, :user_id
  end
end
