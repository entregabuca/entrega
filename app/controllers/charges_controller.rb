class ChargesController < ApplicationController
  
  def index
  	@charges = Charge.all
  end

  def new
  	@charge = Charge.new
  end


  def create
  	@charge = Charge.new(charge_params)
    order = @charge.order
    order.status = 'payment'    
  	if order.save && @charge.save
      render :epayco
  	else
  		render :newstau
  	end
  end

  private

  def charge_params
  	params.require(:charge).permit(:amount, :order_id)
  end

end
