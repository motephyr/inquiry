class Appraisal < ApplicationRecord
  belongs_to :user
  has_many :appraisal_messages
  has_many :appraisal_prices
  belongs_to :category

  scope :recent, -> { order("id DESC")}


end
