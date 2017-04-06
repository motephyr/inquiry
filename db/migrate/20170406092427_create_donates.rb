class CreateDonates < ActiveRecord::Migration[5.0]
  def change
    create_table :donates do |t|
      t.integer :work_id
      t.decimal :price
      t.integer :donor_id
      t.integer :bedonor_id
      t.string :aasm_state
      t.string :token
      t.integer :kind
      t.boolean :has_info

      t.timestamps
    end
    add_index :donates, :work_id
    add_index :donates, :donor_id
    add_index :donates, :bedonor_id
    add_index :donates, :aasm_state
    add_index :donates, :token
  end
end
