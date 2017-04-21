class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  friendly_id :name, use: :slugged

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook]
  acts_as_paranoid

  has_many :appraisals, dependent: :destroy
  has_many :appraisal_messages, dependent: :destroy
  has_many :appraisal_prices, dependent: :destroy
  has_many :cares, dependent: :destroy
  has_many :donor_donates, foreign_key: :donor_id, :class_name => "Donate"
  has_many :bedonor_donates, foreign_key: :bedonor_id, :class_name => "Donate"

  has_one :user_info
  scope :has_user_info, ->{ joins(:user_info).where('user_infos.id is NOT NULL') }
  has_many :works, dependent: :destroy
  has_many :work_messages, dependent: :destroy
  mount_uploader :image, UserImageUploader


  def should_generate_new_friendly_id?
    slug.blank? || name_changed? # slug 為 nil 或 name column 變更時更新
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end


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

  def default_avatar_link
    # 'user-default-image.png'
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Creative-Tail-People-police-man.svg/128px-Creative-Tail-People-police-man.svg.png'
  end

  def avatar_link(method)
    if self.image.present?
      self.image.send(method)
    elsif self.remote_avatar_url.present?
      self.remote_avatar_url
    else
      self.default_avatar_link
    end
  end

  def set_user_provider_id (auth)
    if auth.provider == 'facebook'
      self.fb_id = auth.uid
    end
  end

  def is_admin?
    if (self.email == 'motephyr@gmail.com' || self.email == 'miecowbai@gmail.com')
      true
    else
      false
    end
  end

end
