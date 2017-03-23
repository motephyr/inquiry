class UserSurvey < ApplicationRecord
  belongs_to :category


  def next
    UserSurvey.where("id > ?", self.id).first || UserSurvey.first
  end

  def prev
    UserSurvey.where("id < ?", self.id).last || UserSurvey.fast
  end

end
