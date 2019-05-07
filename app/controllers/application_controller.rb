class ApplicationController < ActionController::Base
	before_action :set_session

	def set_session
		resource, id = request.path.split('/')[1,2]
		if resource == "companies" && id.present?
			cookies.encrypted[:user_type] = resource.singularize.classify
			cookies.encrypted[:user_id] = id.to_i
			puts "SESSION CREATED!!! Company: #{id}"
		else
			cookies.encrypted[:user_type] = nil
			cookies.encrypted[:user_id] = nil
			puts "SESSION IS EMPTY!!!"
		end
	end

end
