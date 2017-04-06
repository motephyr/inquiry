class Donate < ApplicationRecord
  enum kind: [:coffee, :mcdonald, :steak]

  has_one :info, :class_name => "DonateInfo", :dependent => :destroy
  accepts_nested_attributes_for :info
  validates :price, presence: { message: '請選擇金額'}


  #建立訂單必須建立秘密網址
  before_create :generate_token
  def generate_token
    self.token = SecureRandom.uuid
  end

  def set_price_by_kind
    case self.kind
    when "coffee"
      self.price = 60
    when "mcdonald"
      self.price = 120
    when "steak"
      self.price = 1000
    else
      self.price = nil
    end
  end

  include AASM
  aasm do
    state :unpaid, :initial => true
    state :paid, :unrefunded, :refunded

    event :pay do
      transitions from: :unpaid, to: :paid
    end

    event :refund do
      transitions from: :paid, to: :unrefunded
    end

    event :confirm_refund do
      transitions from: :unrefunded, to: :refunded
    end
  end
end
