class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  # GET /orders
  # GET /orders.json
  def index
    @orders = @user.orders
  end

  def transporter_orders    
    @transporter = @user.transporter.find(params[:id])
    @orders = @transporter.orders
  end

  def posts
    coordinates =[@user.locations[0].latitude, @user.locations[0].longitude]
    @orders = Order.posted.select {|o| (Geocoder::Calculations.distance_between(coordinates, \
                [o.locations[0].latitude,o.locations[0].longitude])*1000) <= o.radius ? o : nil}
    render :index
  end

  def posted  
    @orders = @user.orders.posted
    @user = @user  
    render :index
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order= @user.orders.build(status: 'draft')
    #@order= @user.orders.build(status: 'draft', radius: 500)
  end

  # GET /orders/1/edit
  def edit
    #posted_or_taken
  end

  # POST /orders
  # POST /orders.json
  def create

    @order= @user.orders.build(order_params)
      respond_to do |format|
        if @order.save
          format.html { redirect_to url_for([@user, @order]), notice: 'Order was successfully created.' }
          format.json { render :show, status: :created, location: @order }
          order_posted_create
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update

    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to url_for([@user, @order]), notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
        order_posted_update
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy  # only the sender will be allowed to delete orders.
      @order.destroy
      respond_to do |format|
        format.html { redirect_to url_for([@user, :orders]), notice: 'Order was successfully destroyed.' }
        format.json { head :no_content }
      end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def set_user
      resource, id = request.path.split('/')[1,2]
      @user = resource.singularize.classify.constantize.find(id)
    end

    def order_posted_create
      if @order.status == 'posted'
        PostedOrderJob.set(wait: 2.second).perform_later(@order.id) # DELTA_TIME
      end
    end

    def order_posted_update
      @order = Order.find(params[:id])
      if @order.status == 'posted'
      	PostedOrderJob.set(wait: 2.second).perform_later(@order.id) # DELTA_TIME
      end
    end



# Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:description, :weight, :length, :width, :heigth, :pickup_time, :delivery_time, 
        :cost, :status, :radius, :sender_id, :transporter_id, 
        locations_attributes: [:id, :address, :latitude, :longitude])
    end
end

