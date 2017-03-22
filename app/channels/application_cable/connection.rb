module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user ? current_user.name : 'not_login'
    end

    protected
    def find_verified_user
      if cookies.signed['user.id'] && current_user = User.find(cookies.signed['user.id'])
        current_user
      end
    end

  end
end
