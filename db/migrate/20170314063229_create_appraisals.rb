class CreateAppraisals < ActiveRecord::Migration[5.0]
  def change
    create_table :appraisals do |t|
      t.integer :category_id
      t.integer :user_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
