class ApplicationController < ActionController::Base
	before_action :set_session
	before_action :set_locale
	def set_session
		
		if company_signed_in?
			cookies.encrypted[:user_id] = current_company.id
			puts "SESSION CREATED!!! Company: #{current_company.id}"
		else
			cookies.encrypted[:user_id] = nil
			puts "SESSION IS EMPTY!!!"
		end
	end

	private

	def set_locale
		I18n.locale = params[:locale] || I18n.default_locale
	end


	# If commented below it will work but will pull default in english 
	
	def default_url_options(options = {})
	  { locale: I18n.locale }.merge options 
	end


	#def default_url_options
	# { locale: I18n.locale }
	#end


end
