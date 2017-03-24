class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :appraisals
  has_many :appraisal_messages
  has_many :appraisal_prices
  has_many :cares

  has_one :user_info

  def nickname
    self.name || self.user_info.name
  end

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end

  def next
    User.where("id > ?", self.id).first || User.first
  end

  def prev
    User.where("id < ?", self.id).last || User.last
  end

end
