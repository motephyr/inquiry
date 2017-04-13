class WorkMessage < ApplicationRecord
  include PublicActivity::Model
  tracked only: :create, owner: ->(controller, model) {controller && controller.current_user}
  tracked only: :create, task_id: ->(controller, model) {model && model.work.id}
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
  include Careable

  belongs_to :work, :counter_cache => true
  belongs_to :user
end
