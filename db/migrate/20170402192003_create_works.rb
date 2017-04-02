class CreateWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :works do |t|
      t.string :subject
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
