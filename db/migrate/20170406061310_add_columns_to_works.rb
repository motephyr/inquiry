class AddColumnsToWorks < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :attach_avatars, :json
    add_column :works, :attach_url, :string
    add_column :works, :attach_content, :text
  end
end
