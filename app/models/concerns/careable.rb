module Careable
  def self.included(base)
    base.class_eval do
      has_many :cares, as: :careable, :dependent => :destroy
      after_create :add_care
      after_destroy :delete_care
    end
  end

  def add_care
    obj = self
    if self.class.to_s == 'AppraisalMessage'
      obj = self.appraisal
    end

    obj.cares.find_or_create_by(careable_type: obj.class.to_s, careable_id: obj.id,  user: self.user)
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
end