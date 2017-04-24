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
    read_attribute(:typical_work).presence || "相關經歷:(待補) \n作品集連結:(待補)"
  end

  def skill_tool
    read_attribute(:skill_tool).presence || "(待補)"
  end


  def self.ransackable_attributes(auth_object = nil)
    super & %w(work_content work_area skill_tool)
  end

end
