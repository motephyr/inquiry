class Appraisal < ApplicationRecord
  include PublicActivity::Model
  tracked only: :update, owner: ->(controller, model) {controller && controller.current_user}
  tracked only: :update, task_id: ->(controller, model) {model && model.id}
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
  include Careable

  belongs_to :user
  has_many :appraisal_messages
  has_many :appraisal_prices
  belongs_to :category

  scope :recent, -> { order("id DESC")}

end
