class ReviewsController < ApplicationController
  before_action :set_user, only: [:index, :show, :new, :create]
  before_action :set_service, only: [:index, :show, :new, :create]
  before_action :set_contract, only: [:show, :new, :create]
  before_action :set_review, only: [:edit, :update]
  before_action :authenticate_user!

  def index
    @service_provider_contracts = Contract.joins(:service).where(services: { user_id: @user.id })
    contract_ids = @service_provider_contracts.pluck(:id)
    @reviews = Review.where(contract_id: contract_ids)
  end

  def show
    @service_provider_contracts = Contract.joins(:service).where(services: { user_id: @user.id })
    @reviews = Review.where(contract_id: @service_provider_contracts.pluck(:id))
  end

  def new
    @contract = Contract.find(params[:contract_id])
    @review = Review.new
  end

  def create
    @contract = Contract.find(params[:contract_id])
    @review = @contract.build_review(review_params)
    @review.contract = @contract
    if @review.save
      redirect_to dashboard_path(@contract), notice: 'Review was successfully created.'
    else
      render :new, status: :unprocessable_entity, notice: 'Unable to create review.'
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to dashboard_path, notice: 'Review was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_service
    @service = Service.find(params[:service_id])
  end

  def set_contract
    @contract = Contract.find(params[:contract_id])
  end
end
