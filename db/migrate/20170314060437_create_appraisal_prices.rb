class CreateAppraisalPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :appraisal_prices do |t|
      t.integer :user_id
      t.integer :appraisal_id
      t.integer :price

      t.timestamps
    end
  end
end
