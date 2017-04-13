class AddWorkMessagesCount < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :work_messages_count, :integer, default: 0
  end
end
