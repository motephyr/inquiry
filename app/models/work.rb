class Work < ApplicationRecord
  belongs_to :user
  has_many :donates

  validates :user_id, presence: true
  attr_accessor :remote_attach_avatar_url

  mount_uploader :attach_avatar, AvatarUploader

  extend FriendlyId
  friendly_id :subject, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || subject_changed?
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  def subject
    read_attribute(:subject).presence || "無題"
  end
end
