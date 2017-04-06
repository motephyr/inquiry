class DonateInfo < ApplicationRecord
  belongs_to :donate

  validates :name, :presence => true
  validates :address, :presence => true
end
