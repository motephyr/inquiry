class AppraisalMessage < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  tracked recipient: ->(controller, model) { model && model.appraisal.user }

  belongs_to :appraisal, :counter_cache => true
  belongs_to :user
end
