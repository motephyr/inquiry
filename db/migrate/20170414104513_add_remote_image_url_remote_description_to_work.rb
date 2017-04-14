class AddRemoteImageUrlRemoteDescriptionToWork < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :remote_image_url, :string, default: ''
    add_column :works, :remote_description, :string, default: ''
  end
end
