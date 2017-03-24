class Care < ApplicationRecord
  belongs_to :careable, polymorphic: true
  belongs_to :user
end
