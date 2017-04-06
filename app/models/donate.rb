class Donate < ApplicationRecord
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
