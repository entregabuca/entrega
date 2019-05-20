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
      end
      return
    elsif sender_signed_in?
      @user = current_sender
    elsif company_signed_in?
      @user = current_company
    elsif transporter_signed_in?
      @user = current_transporter  
    else
      return redirect_to :root
    end 

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