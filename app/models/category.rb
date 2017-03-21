class Category < ApplicationRecord
  has_many :appraisals
  has_many :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent_category, class_name: "Category", foreign_key: "parent_id", optional: true
  has_one :user_survey
  has_one :user_info

end
