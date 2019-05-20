module ApplicationCable
  class Connection < ActionCable::Connection::Base
  	identified_by :current_company

    def connect
      self.current_company = find_verified_company
    end

    private
      def find_verified_company
        if verified_company = Company.find(cookies.encrypted[:user_id])
          puts "CONNECTED AS: #{verified_company.name}"
          verified_company
        else
          reject_unauthorized_connection
          puts "NOT CONNECTED"
        end
      end
  end
end
