class AddCountToAppraisal < ActiveRecord::Migration[5.0]
  def change
    add_column :appraisals, :appraisal_messages_count, :integer, :default => 0

    Appraisal.pluck(:id).each do |i|
      Appraisal.reset_counters(i, :appraisal_messages) # 全部重算一次
    end
    add_column :appraisals, :appraisal_prices_count, :integer, :default => 0
    Appraisal.pluck(:id).each do |i|
      Appraisal.reset_counters(i, :appraisal_prices) # 全部重算一次
    end
  end
end
