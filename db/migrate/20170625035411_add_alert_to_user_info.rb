class AddAlertToUserInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :user_infos, :alert, :text
  end
end
