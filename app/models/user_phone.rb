class UserPhone < ApplicationRecord
    belongs_to :user
    validates :user_id, presence: true
    validates :phone_number, presence: true, length: {is: 10}
    validates :minute_rate, presence: true,  :format => { :with => /\A\d+(?:\.\d{0,1})?\z/ }, :numericality => {:greater_than => 0, :less_than => 100}

end
