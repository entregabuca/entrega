module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user    
    if ((admin_signed_in? ? 1 : 0) + (sender_signed_in? ? 1 : 0) + (company_signed_in? ? 1 : 0) + (transporter_signed_in? ? 1 : 0)) > 1
      flash.clear
      sign_out_all_scopes
      return redirect_to :root
    elsif admin_signed_in?
      resource, id = request.path.split('/')[1,2]
      if id
        @user = resource.singularize.classify.constantize.find(id)
      else
        @user = current_admin
      end
    elsif sender_signed_in?
      @user = current_sender
    elsif company_signed_in?
      @user = current_company
    elsif transporter_signed_in?
      @user = current_transporter  
    else
      return redirect_to :root
    end

    ### Write the cookie for the Notification Channel
    if @user
      cookies.encrypted[:user_id] = @user.id
      cookies.encrypted[:user_type] = @user.class.name
      puts "SESSION CREATED!!! Company: #{@user.id}"
    else
      cookies.encrypted[:user_id] = nil
      cookies.encrypted[:user_type] = nil
      puts "SESSION IS EMPTY!!!"
    end

    if !admin_signed_in?
      resource, id = request.path.split('/')[1,2] 
      if resource && id
        if @user.class.name != resource.singularize.classify || @user.id != id.to_i
          return redirect_to @user
        end
      else
        return redirect_to @user
      end
    end
  end
end