class CreateUserInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_infos do |t|
      t.integer :user_id
      t.text :work_content
      t.text :work_area
      t.text :typical_work
      t.integer :teach
      t.integer :speak
      t.integer :labor
      t.integer :contract
      t.integer :category_id

      t.timestamps
    end
  end
end
