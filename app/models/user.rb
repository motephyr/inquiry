class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_paranoid

  has_many :appraisals, dependent: :destroy
  has_many :appraisal_messages, dependent: :destroy
  has_many :appraisal_prices, dependent: :destroy
  has_many :cares, dependent: :destroy

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
