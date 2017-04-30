class Care < ApplicationRecord
  belongs_to :careable, polymorphic: true
  # belongs_to :appraisal, ->{ joins(:cares).where(cares: {id: Care.where(careable_type: 'Appraisal')}) }, foreign_key: :careable_id
  # belongs_to :appraisal_message, -> { joins(:activities).where(activities: {trackable_type: 'AppraisalMessage'}) }, foreign_key: 'trackable_id'
  include PublicActivity::Model
  tracked only: :create, owner: ->(controller, model) {controller && controller.current_user}
  tracked only: :create, task_id: ->(controller, model) {model && model.careable_type == 'Work' && model.id}
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  belongs_to :user
  validates :user_id, :uniqueness => {:scope => [:careable_type, :careable_id]}, presence: true
  scope :recent, -> { order("id DESC")}

end
