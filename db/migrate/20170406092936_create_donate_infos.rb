class CreateDonateInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :donate_infos do |t|
      t.integer :donate_id
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
