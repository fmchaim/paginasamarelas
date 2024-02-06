require 'csv'
class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:search].present? and params[:city].present?
      @services = Service.joins(:user).where('category ILIKE ? or city ILIKE ?', "%#{params[:search]}%", "%#{params[:city]}%")
    else
      if params[:search].present?
        @services = Service.where('category ILIKE ?', "%#{params[:search]}%")
      else
        @services = Service.all
    end
  end
  end


  def servdashboard
    @services = Service.all
  end


  def show
  end

  def new
    @service = Service.new
  end

  def edit
  end

  def create
    @service = current_user.services.create(service_params)
    if @service.save
      redirect_to dashboard_path(current_user)
    else
      render :new
    end
  end

  def update
    if @service.update(service_params)
      redirect_to dashboard_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @service.destroy
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name_service, :description_service,
                                    :photo, :category, :price, :address, :user_id)
  end


end
