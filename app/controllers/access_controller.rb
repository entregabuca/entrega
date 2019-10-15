class AccessController < ApplicationController

  def home
  	if sender_signed_in?
      redirect_to(new_sender_order_path(current_sender))
  	elsif company_signed_in?
  		redirect_to(current_company)
  	elsif transporter_signed_in?
  		redirect_to(current_transporter)
  	end
  end
end
