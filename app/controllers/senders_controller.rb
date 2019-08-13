class SendersController < ApplicationController
  include Accessible

  def index
    @users = Sender.all
  end


  def show
  end


  def new
    @user = Sender.new
  end

  def edit
  end


  def create
    @user = Sender.new(sender_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Sender was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update

    respond_to do |format|
      if @user.update(sender_params)
        format.html { redirect_to @user, notice: 'Sender was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    if @user.orders.size == 0
      @user.destroy
      respond_to do |format|
        format.html { redirect_to senders_url, notice: 'Sender was successfully destroyed.' }
        format.json { head :no_content }
      end
    else 
      respond_to do |format|
        format.html { redirect_to senders_url, alert: 'This Sender can only chage its status to Inactive' }
        format.json { head :no_content }
      end 
    end
  end

  private

    def sender_params
      params.require(:sender).permit(:name, :telephone, :email, :status, locations_attributes: [:id, :address, :latitude, :longitude])
    end
end
