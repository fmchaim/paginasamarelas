require 'csv'
class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]


  def index
    @services = Service.where("category LIKE ?", "%#{params[:search]}%")
    @categorys = CSV.read(Rails.root.join('db', 'category.csv')).flatten
  end

  def show
  end

  def new
    @service = Service.new
    @categorys = CSV.read(Rails.root.join('db', 'category.csv')).flatten
    #@user = User.new(service: @service)
  end

  def edit
  end

  def create
    @service = current_user.services.create(service_params)
    if @service.save
      redirect_to @service
    else
      render :new
    end
  end

  def update
    if @service.update(service_params)
      redirect_to @service
    else
      render :edit
    end
  end

  def destroy
    @service.destroy
    redirect_to lists_path
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name_service, :description_service,
                                    :photos, :category, :price, :user_id)
  end


end
