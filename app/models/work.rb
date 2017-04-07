class Work < ApplicationRecord
  belongs_to :user
  has_many :donates

  validates :subject, presence: true
  validates :content, presence: true
  validates :user_id, presence: true

  mount_uploaders :attach_avatars, AvatarUploader

  extend FriendlyId
  friendly_id :subject, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || subject_changed?
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end
end
