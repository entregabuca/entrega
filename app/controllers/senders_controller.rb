class SendersController < ApplicationController
  before_action :set_sender, only: [:show, :edit, :update, :destroy]

  # GET /senders
  # GET /senders.json
  def index
    @users = Sender.all
  end

  # GET /senders/1
  # GET /senders/1.json
  def show
  end

  # GET /senders/new
  def new
    @user = Sender.new
  end

  # GET /senders/1/edit
  def edit
  end

  # POST /senders
  # POST /senders.json
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

  # PATCH/PUT /senders/1
  # PATCH/PUT /senders/1.json
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

  # DELETE /senders/1
  # DELETE /senders/1.json
  def destroy
    if @user.orders.size == 0
      @user.destroy
      respond_to do |format|
        format.html { redirect_to senders_url, notice: 'Sender was successfully destroyed.' }
        format.json { head :no_content }
      end
    else 
      respond_to do |format|
        format.html { redirect_to senders_url, notice: 'This Sender can only chage its status to Inactive' }
        format.json { head :no_content }
      end 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sender
      @user = Sender.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sender_params
      params.require(:sender).permit(:name, :telephone, :email, :status, locations_attributes: [:id, :address, :latitude, :longitude])
    end
end
