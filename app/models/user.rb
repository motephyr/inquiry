class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  acts_as_paranoid

  has_many :appraisals, dependent: :destroy
  has_many :appraisal_messages, dependent: :destroy
  has_many :appraisal_prices, dependent: :destroy
  has_many :cares, dependent: :destroy

  has_one :user_info
  scope :has_user_info, ->{ joins(:user_info).where('user_infos.id is NOT NULL') }

  def self.from_omniauth(auth)
    data = auth.info
    user = User.where(:email => data["email"]).first

    if user
      user.set_user_provider_id auth
      user.save!
    else
      user = User.create(name: data["name"],
         email: data["email"],
         password: Devise.friendly_token[0,20],
         remote_avatar_url: data['image']
      )
      user.set_user_provider_id auth
    end
    user
  end

  def nickname
    self.name || self.user_info.name
  end

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end

  def next
    User.has_user_info.where("users.id > ?", self.id).first || User.has_user_info.first
  end

  def prev
    User.has_user_info.where("users.id < ?", self.id).last || User.has_user_info.last
  end

  def avatar_link
    if self.image.present?
      self.image
    elsif self.remote_avatar_url.present?
      self.remote_avatar_url
    else
      'user-default-image.png'
    end
  end

  def set_user_provider_id (auth)
    if auth.provider == 'facebook'
      self.fb_id = auth.uid
    end
  end

end
