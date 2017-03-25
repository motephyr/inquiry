class AppraisalPrice < ApplicationRecord
  belongs_to :appraisal, :counter_cache => true
  belongs_to :user

  validates :user_id, :uniqueness => {:scope => :appraisal_id}
  validates :price, presence: true

end
