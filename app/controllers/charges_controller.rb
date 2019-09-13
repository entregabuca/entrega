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


# lines 31 and 33 to be checked!!!

def create
    puts " ON CREATED CONTROLLER"
    @charge = Charge.new(charge_params)
    puts " THIS IS THE CREATED CHARGE  #{@charge}"
    @order = @charge.order
    if Rails.env == "production"
      puts " PRODUCTION. THIS IS WHAT IS SEEN AS CHARGE #{@charge}"
      puts " PRODUCTION. ORDER SENT FOR PAYMENT!!! @ORDER.STATUS is #{@order.status.capitalize} "
      puts " PRODUCTION. ORDER SENT FOR PAYMENT!!! @CHARGE.STATUS is #{@charge.status.capitalize} "
      puts " PRODUCTION. ORDER SENT FOR PAYMENT!!! @ORDER.CHARGE.STATUS is #{@order.charge.status.capitalize}"
      puts " PRODUCTION. ORDER SENT FOR PAYMENT!!! @CHARGE.AMOUNT is #{@charge.amount} "
      @order.status = 'payment'    
      if @order.save && @charge.save
        puts " PRODUCTION. IF ORDER AND CHARGE SAVED. VALUES AFTER SAVE."
        puts " PRODUCTION. VALUES AFTER SAVE. THIS IS WHAT IS SEEN AS CHARGE #{@charge}"
        puts " PRODUCTION. VALUES AFTER SAVE. @ORDER.STATUS is #{@order.status.capitalize} "
        puts " PRODUCTION. VALUES AFTER SAVE. @CHARGE.STATUS is #{@charge.status.capitalize} "
        puts " PRODUCTION. VALUES AFTER SAVE. @ORDER.CHARGE.STATUS is #{@order.charge.status.capitalize}"
        puts " PRODUCTION. VALUES AFTER SAVE. @CHARGE.AMOUNT is #{@charge.amount} "
        render :epayco
      else
        render :newstau
      end
    else
      puts "   DEVELOPMENT. ORDER SENT FOR PAYMENT!!! @ORDER.STATUS is #{@order.status.capitalize} "
      puts "   DEVELOPMENT. ORDER SENT FOR PAYMENT!!! @CHARGE.STATUS is #{@charge.status.capitalize} "
      puts "   DEVELOPMENT. ORDER SENT FOR PAYMENT!!! @ORDER.CHARGE.STATUS is #{@order.charge.status.capitalize}"
      puts "   DEVELOPMENT. ORDER SENT FOR PAYMENT!!! @CHARGE.AMOUNT is #{@charge.amount} "
      @order.status = 'posted'  
      respond_to do |format|
        puts "  DEVELOPMENT.ORDER STATUS AFTER SETTING IT TO STATUS = POSTED WHENT SENT FOR PAYMENT!!! @ORDER.STATUS is #{@order.status.capitalize} "
        puts "  DEVELOPMENT.ORDER STATUS AFTER SETTING IT TO STATUS = POSTED ORDER SENT FOR PAYMENT!!! @ORDER.CHARGE.STATUS is #{@order.charge.status.capitalize} "
        if @order.save
          puts "   Notification Sent to Sender #{@order.sender.id}"
          NotificationChannel.broadcast_to(@order.sender,
                title: 'Notificación', 
                body: "El Estado de la <a href=""#{url_for([@order.sender, @order])}""> orden No: #{@order.id.to_s} </a>, 
                      ha cambiado.")

          format.html { redirect_to url_for([@user, @order]), notice: 'Order successfully sent for payment.' }
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
