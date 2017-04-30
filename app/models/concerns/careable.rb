module Careable
  def self.included(base)
    base.class_eval do
      has_many :cares, as: :careable, :dependent => :destroy
      attr_readonly :cares_count
      after_create :add_care      #dependent觸發
      after_destroy :delete_care  #dependent觸發
    end
  end



  def add_care  #你留言表示你care appraisal
    if self.class.to_s == 'AppraisalMessage'
      obj = self.appraisal

      obj.cares.find_or_create_by(careable_type: obj.class.to_s, careable_id: obj.id,  user: self.user)
    end


  end

  def delete_care
    obj = self
    if self.class.to_s == 'AppraisalMessage'
      obj = self.appraisal
      user_ids = obj.appraisal_messages.map {|x| x.user_id}.uniq
      if !user_ids.any? {|h| h == self.user_id}
        obj.cares.find_by(careable_type: obj.class.to_s, careable_id: obj.id,  user: self.user).destroy
      end
    else
      obj.cares.destroy_all
    end
  end

  def care_by(user)
    increment_counter
    obj = self
    obj.cares.find_or_create_by(careable_type: obj.class.to_s, careable_id: obj.id,  user: user)
  end

  def uncare_by(user)
    decrement_counter
    obj = self
    obj.cares.find_by(careable_type: obj.class.to_s, careable_id: obj.id,  user: user).destroy
  end


  def is_care_by?(user)
    if user.present?
      self.cares.any? {|h| h.user_id == user.id}
    end
  end

  private

  # increments the right classifiable counter for the right taxonomy
  def increment_counter
    self.class.increment_counter("cares_count", self.id)
  end

  # decrements the right classifiable counter for the right taxonomy
  def decrement_counter
    self.class.decrement_counter("cares_count", self.id)
  end
end