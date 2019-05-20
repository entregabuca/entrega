class ApplicationController < ActionController::Base
	before_action :set_session

	def set_session
		
		if company_signed_in?
			cookies.encrypted[:user_id] = current_company.id
			puts "SESSION CREATED!!! Company: #{current_company.id}"
		else
			cookies.encrypted[:user_id] = nil
			puts "SESSION IS EMPTY!!!"
		end
	end
end
