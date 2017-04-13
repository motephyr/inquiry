class AddHitsToWork < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :hits, :integer, default: 0
  end
end
