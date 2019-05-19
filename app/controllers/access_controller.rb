class AccessController < ApplicationController

  def home
  	if sender_signed_in?
  		redirect_to(current_sender)
  	elsif company_signed_in?
  		redirect_to(current_company)
  	elsif transporter_signed_in?
  		redirect_to(current_transporter)
  	end
  end
end
