class AddEditedToUserSurvey < ActiveRecord::Migration[5.0]
  def change
    add_column :user_surveys, :edited, :boolean, default: false
  end
end
