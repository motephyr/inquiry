class AppraisalPrice < ApplicationRecord
  belongs_to :appraisal
  belongs_to :user
end
