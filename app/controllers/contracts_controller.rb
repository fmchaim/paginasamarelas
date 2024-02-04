class ContractsController < ApplicationController
  before_action :set_service, only: [:new, :create]
  before_action :set_contract, only: [:show, :edit, :update, :done, :update_status]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @contracts = Contract.where('user_id = ? OR service_id = ?', current_user.id, @contract.service_id.user_id)
  end

  def show
    @contract = Contract.where('service_id = ? OR user_id = ?', @contract.service_id, current_user.id)
  end

  def new
    @contract = Contract.new
  end

  def update_status
    @constract.status = params[:status]
    @contract.save
  end

  def create
    @contract = Contract.new(contract_params)
    @contract.user = current_user # Atribuindo o usuário logado ao contrato
    @contract.service = @service # Atribuindo o serviço ao contrato
    @contract.status = 'pending' # Definindo o status inicial do contrato

    if @contract.save
      redirect_to dashboard_path(@contract), notice: 'contract created successfully!'
    else
      render :new, status: :unprocessable_entity, notice: 'Unable to create contract.'
    end
  end

  def edit
    render :show
  end

  def update
    @contract = Contract.find(params[:id])
    new_status = params[:status] # 'accept' ou 'reject'

    if current_user.id == @contract.service.user_id # Verifica se o usuário logado é o prestador do serviço
      if @contract.update(status: new_status)
        redirect_to dashboard_path(@contract), notice: 'Contract updated successfully.'
      else
        render :edit
      end
    else
      redirect_to dashboard_path(@contract), notice: 'You are not permitted to change this agreement.'
    end
  end

  # Ação personalizada para marcar o contrato como concluído
  def done
    if current_user.id == @contract.service_id.user_id # Verifica se o usuário logado é o prestador do serviço
      @contract.update(done: true)
      redirect_to dashboard_path(@contract), notice: 'Contract completed successfully.'
    else
      redirect_to dashboard_path(@contract), notice: 'You are not allowed to mark this contract as complete.'
    end
  end

  private

  def contract_params
    params.require(:contract).permit(:user_id, :service_id, :date, :status, :done)
  end

  def set_service
    @service = Service.find(params[:service_id])
  end

  def set_contract
    @contract = Contract.find(params[:id])
  end
end



# <%= link_to 'Accept', update_status_contract_path(@contract, status: 'accept'), method: :patch %>
# <%= link_to 'Decline', update_status_contract_path(@contract, status: 'decline'), method: :patch %> <--- PARA A VIEW
