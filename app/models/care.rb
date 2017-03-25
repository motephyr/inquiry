class Care < ApplicationRecord
  belongs_to :careable, polymorphic: true
  belongs_to :user
  validates :user_id, :uniqueness => {:scope => [:careable_type, :careable_id]}, presence: true

end
