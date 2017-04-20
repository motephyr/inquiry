class ChangePublishToWork < ActiveRecord::Migration[5.0]
  def change
    change_column :works, :is_published, :boolean, default: false
  end
end
