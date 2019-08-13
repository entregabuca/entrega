class RecipientsController < ApplicationController
  before_action :set_recipient, only: [:show, :edit, :update, :destroy]

  def index
    @recipients = Recipient.all
  end


  def show
  end


  def new
    @recipient = Recipient.new
  end

  def edit
  end

  def create
    @recipient = Recipient.new(recipient_params)

    respond_to do |format|
      if @recipient.save
        format.html { redirect_to @recipient, notice: 'Recipient was successfully created.' }
        format.json { render :show, status: :created, location: @recipient }
      else
        format.html { render :new }
        format.json { render json: @recipient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipient.update(recipient_params)
        format.html { redirect_to @recipient, notice: 'Recipient was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipient }
      else
        format.html { render :edit }
        format.json { render json: @recipient.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @recipient.destroy
    respond_to do |format|
      format.html { redirect_to recipients_url, notice: 'Recipient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_recipient
      @recipient = Recipient.find(params[:id])
    end

    def recipient_params
      params.require(:recipient).permit(:name, :telephone, :email, :order_id)
    end
end
