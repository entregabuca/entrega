module ApplicationCable
  class Connection < ActionCable::Connection::Base
  	identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
      def find_verified_user
        if cookies.encrypted[:user_id] != nil
          if verified_user = cookies.encrypted[:user_type].constantize.find(cookies.encrypted[:user_id])
            puts "CONNECTED AS:: #{verified_user.class.name}: #{verified_user.has_attribute?(:name) ? verified_user.name : verified_user.id}"
            verified_user
          else
            reject_unauthorized_connection
            puts "NOT CONNECTED"
          end
        else
          puts "NOT CONNECTED2"
        end
      end
  end
end
