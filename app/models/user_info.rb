class UserInfo < ApplicationRecord
  belongs_to :category
  belongs_to :user

  def nickname
    self.user.name || self.name
  end

  def work_content
    read_attribute(:work_content).presence || "(待補)"
  end

  def typical_work
    read_attribute(:typical_work).presence || "(待補)"
  end

  def skill_and_tool
    read_attribute(:skill_and_tool).presence || "(待補)"
  end


end
