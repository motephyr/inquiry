class ChangeColumnUserInfo < ActiveRecord::Migration[5.0]
  def change
    change_column :user_infos, :work_area, :string
  end
end
