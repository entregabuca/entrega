class ChargesController < ApplicationController
 include Accessible 

  def index
  	@charges = Charge.all
  end

  def new
  	@charge = Charge.new
  end


#  def create
#    puts " Entro"
#    @charge = Charge.new(charge_params)
#    order = @charge.order
#    order.status = 'payment'    
#    if order.save && @charge.save
#      render :epayco
#    else
#      render :newstau
#    end
#  end




def create
    #puts " Entro al Create"
    @charge = Charge.new(charge_params)
    @order = @charge.order
    if Rails.env == "production"
      @order.status = 'payment'    
      if @order.save && @charge.save
        render :epayco
      else
        render :newstau
      end
    else
        #puts " Redirecionando a Orden"
        puts "USER ID = #{@user.id}"
        puts "URL = #{url_for([@user, @order])}"
      @order.status = 'posted'  
      respond_to do |format|
        if @order.save
          
          #draft_or_posted
          format.html { redirect_to url_for([@user, @order]), notice: 'Order was successfully Paid.' }
          format.json { render :show, status: :created, location: @order }
          #order_posted_create
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end





  private

  def charge_params
  	params.require(:charge).permit(:amount, :order_id)
  end

end
