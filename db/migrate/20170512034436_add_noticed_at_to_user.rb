class AddNoticedAtToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :noticed_at, :datetime, :null => false, :default => Time.now
  end
end
