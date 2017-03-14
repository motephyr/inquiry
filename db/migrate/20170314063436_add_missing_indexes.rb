class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :appraisal_prices, :appraisal_id
    add_index :appraisal_prices, :user_id
    add_index :appraisal_messages, :appraisal_id
    add_index :appraisal_messages, :user_id
    add_index :appraisals, :user_id
    add_index :appraisals, :category_id
  end
end
