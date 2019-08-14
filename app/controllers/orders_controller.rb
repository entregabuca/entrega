class OrdersController < ApplicationController
  include Accessible 

  before_action :set_order, only: [:show, :edit, :update, :destroy]
  #before_action :set_user

  def index
    @orders = @user.orders
  end

  def transporter_orders    
    @transporter = @user.transporter.find(params[:id])
    @orders = @transporter.orders
  end

  def posts
    if @user.locations.present?
      coordinates =[@user.locations[0].latitude, @user.locations[0].longitude]
      @orders = Order.posted.select {|o| (Geocoder::Calculations.distance_between(coordinates, \
                  [o.locations[0].latitude,o.locations[0].longitude])*1000) <= o.radius ? o : nil}
    else
      @orders = []
    end

    render :index
  end

  def posted  
    @orders = @user.orders.posted
    @user = @user  
    render :index
  end

  def show
   # if @order.charge.present?
   #   @charge = @order.charge
   # else
      @charge = Charge.new
   # end
  end

  def new
    @order = @user.orders.build(status: 'draft')
  end


  def edit

  end

  def create
    @order= @user.orders.build(order_params)
    calculate_cost
      respond_to do |format|
        if @order.save
          
          #draft_or_posted
          format.html { redirect_to url_for([@user, @order]), notice: t(:order_created)}
          format.json { render :show, status: :created, location: @order }
          #order_posted_create
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
  end

  def update
    calculate_cost
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to url_for([@user, @order]), notice: t(:order_updated) }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy  # At the moment only the sender will be allowed to delete orders .
      @order.destroy
      respond_to do |format|
        format.html { redirect_to url_for([@user, :orders]), notice: t(:order_removed) }
        format.json { head :no_content }
      end
    
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def set_user
      resource, id = request.path.split('/')[1,2]
      @user = resource.singularize.classify.constantize.find(id)
    end

  # def order_posted_create
  #   if @order.status == 'posted'
  #     PostedOrderJob.perform_later(@order.id) # DELTA_TIME
  #   end
  # end

  # def order_posted_update
  #   @order = Order.find(params[:id])
  #   if @order.status == 'posted'
  #   	PostedOrderJob.set(wait: 2.second).perform_later(@order.id) # DELTA_TIME
  #   end
  # end

    #def draft_or_posted     
    #  if params[:commit] == 'Save Draft' ||  params[:commit] == 'Borrador' 
    #    @order.update(status: 'draft', radius: 500)      
    #  elsif params[:commit] == 'Payment' ||  params[:commit] == 'Pagando' 
    #    @order.update(status: 'payment', radius: 500)     
    #  end
    #end 
    
# See how I can make this Two(2) last methods available globally
    def enum_l(model, enum)
      enum_i18n(model.class, enum, model.send(enum))
    end

    def enum_i18n(class_name, enum, key)
     I18n.t("activerecord.enums.#{class_name.model_name.i18n_key}.#{enum.to_s.pluralize}.#{key}")
    end


    def calculate_cost
      @order.cost = 40000
    end

    def order_params
      params.require(:order).permit(:description, :weight, :length, :width, :heigth, :pickup_time, :delivery_time, 
        :cost, :status, :radius, :sender_id, :transporter_id,
        locations_attributes: [:id, :address, :latitude, :longitude], recipients_attributes: [:name, :telephone, :email])
    end
end

