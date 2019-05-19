class CompaniesController < ApplicationController
  include Accessible
  before_action :authenticate_company!, except: [:index]
  #before_action :set_company, only: [:show, :edit, :update, :destroy]

  
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all

    if params[:search].present? & params[:radius].present?
      @search_coordinates = Geocoder.search(params[:search]).first.coordinates
      @companies_near = Company.near(@search_coordinates, params[:radius].to_f/1000, {:units => :km})
    else
      @companies_near = Company.all
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @user = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
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

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
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

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    if @user.orders.size == 0
      @user.destroy
      respond_to do |format|
        format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
        format.json { head :no_content }
      end
    else 
      respond_to do |format|
        format.html { redirect_to companies_url, notice: 'This Company can only chage its status to Inactive' }
        format.json { head :no_content }
      end 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_company
      if current_company.id == params[:id].to_i
        @user = current_company
      else
        sign_out(current_company)
        redirect_to new_company_session_path
      end
    end

    def set_user
      resource, id = request.path.split('/')[1,2]
      @user = resource.singularize.classify.constantize.find(id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :telephone, :email, :radius, 
        :status, locations_attributes: [:id, :address, :latitude, :longitude])
    end
end
