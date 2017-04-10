class ChangeWorkAttachAvatar < ActiveRecord::Migration[5.0]
  def change
    remove_column :works,  :attach_avatars
    add_column :works,  :attach_avatar, :string
  end
end
