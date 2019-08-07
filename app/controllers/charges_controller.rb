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
      @order.status = 'posted'  
      respond_to do |format|
        if @order.save
          puts "   Notification Sent to Sender #{@order.sender.id}"
          NotificationChannel.broadcast_to(@order.sender,
                title: 'Notificación', 
                body: "El Estado de la <a href=""#{url_for([@order.sender, @order])}""> orden No: #{@order.id.to_s} </a>, 
                      ha cambiado.")

          format.html { redirect_to url_for([@user, @order]), notice: 'Order was successfully Paid.' }
          format.json { render :show, status: :created, location: @order }

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
