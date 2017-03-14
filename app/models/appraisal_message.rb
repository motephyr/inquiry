class AppraisalMessage < ApplicationRecord
  belongs_to :appraisal, :counter_cache => true
  belongs_to :user
end
