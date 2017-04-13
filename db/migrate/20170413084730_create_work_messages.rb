class CreateWorkMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :work_messages do |t|
      t.integer :user_id
      t.integer :work_id
      t.text :content

      t.timestamps
    end
    add_index :work_messages, :user_id
    add_index :work_messages, :work_id
  end
end
