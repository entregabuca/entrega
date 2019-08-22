class TransportersController < ApplicationController
  include Accessible
  before_action :set_transporter, only: [:show, :edit, :update, :destroy, :orders]


  def index
    if @user.present?
      @transporters = @user.transporters
    else 
      @transporters = Transporter.all
    end
  end


  def show
  end

  def orders 
    @orders = @transporter.orders 
    render 'orders/index'
  end

  def new    
    @transporter = @user.transporters.build 
  end


  def edit
  end


  def create
    
    @transporter = @user.transporters.build(transporter_params)

    respond_to do |format|
      if @transporter.save
        format.html { redirect_to company_transporter_path(@user, @transporter), notice: t(:transporter_created) }
        format.json { render :show, status: :created, location: @transporter }
      else
        format.html { render :new }
        format.json { render json: @transporter.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @transporter.update(transporter_params)
        format.html { redirect_to company_transporter_path(@user, @transporter), notice: t(:transporter_updated) } 
        format.json { render :show, status: :ok, location: @transporter }
      else
        format.html { render :edit }
        format.json { render json: @transporter.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transporter.destroy
    respond_to do |format|
      format.html { redirect_to company_transporters_path(@user), notice: t(:transporter_removed) }
      format.json { head :no_content }
    end
  end

  private

    def set_transporter
      @transporter = Transporter.find(params[:id])
    end

    def transporter_params
      params.require(:transporter).permit(:name, :telephone, :email, :status, :company_id, :password)
    end
end
