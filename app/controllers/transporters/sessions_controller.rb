# frozen_string_literal: true

class Transporters::SessionsController < Devise::SessionsController
#  # before_action :configure_sign_in_params, only: [:create]
 #before_action :set_status, only: [:destroy]
#  # GET /resource/sign_in
#  # def new
#  #   super
#  # end
#
#  # POST /resource/sign_in
#  # def create
#  #   super
#  # end
#
#  # DELETE /resource/sign_out
  def destroy
    if transporter_signed_in? 
      current_transporter
      current_transporter.status = "offwork"
      current_transporter.save
      sign_out(current_transporter) 
      redirect_to root_path
   end
  end
#
   private

   # def set_status
   #   @transporter = Transporter.find(params[:id])
   #   @transporter.status = "offwork"
   # end
#  # protected
#
#  # If you have extra params to permit, append them to the sanitizer.
#  # def configure_sign_in_params
#  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
#  # end
end
#