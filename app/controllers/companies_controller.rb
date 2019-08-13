class CompaniesController < ApplicationController
  include Accessible

  def index
    @companies = Company.all

    if params[:search].present? & params[:radius].present?
      @search_coordinates = Geocoder.search(params[:search]).first.coordinates
      @companies_near = Company.near(@search_coordinates, params[:radius].to_f/1000, {:units => :km})
    else
      @companies_near = Company.all
    end
  end

  def show
  end


  def new
    @user = Company.new
  end


  def edit
  end

  def create
    @user = Company.new(company_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @user.update(company_params)
        format.html { redirect_to @user, notice: 'Company was successfully updated.' }
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
        format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
        format.json { head :no_content }
      end
    else 
      respond_to do |format|
        format.html { redirect_to companies_url, alert: 'This Company can only chage its status to Inactive' }
        format.json { head :no_content }
      end 
    end
  end

  private

    def company_params
      params.require(:company).permit(:name, :telephone, :email, :radius, 
        :status, locations_attributes: [:id, :address, :latitude, :longitude])
    end
end
