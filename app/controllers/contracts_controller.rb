class ContractsController < ApplicationController
  before_action :set_service, only: [:new, :create]
  before_action :set_contract, only: [:show, :edit, :update, :done]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @contracts = Contract.where('user_id = ?', current_user.id)

    # @contracts = current_user.contracts
  end

  def show
    @contract = Contract.where('service_id = ?', @contract.service_id)
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    @contract.user = current_user # Atribuindo o usuário logado ao contrato
    @contract.service = @service # Atribuindo o serviço ao contrato

    if @contract.save
      redirect_to dashboard_path(@contract), notice: 'Contrato criado com sucesso.'
    else
      render :new, status: :unprocessable_entity, notice: 'Não foi possível criar o contrato.'
    end
  end

  def edit
    render :show
  end

  # Ação personalizada para aceitar ou rejeitar o contrato
  def update
    @contract = Contract.find(params[:id])
    new_status = params[:status] # 'accept' ou 'decline'

    if current_user.id == @contract.service.user_id # Verifica se o usuário logado é o prestador do serviço
      if @contract.update(status: new_status)
        redirect_to dashboard_path(@contract), notice: 'Contrato atualizado com sucesso.'
      else
        render :edit
      end
    else
      redirect_to dashboard_path(@contract), notice: 'Você não tem permissão para alterar este contrato.'
    end
  end

  # Ação personalizada para marcar o contrato como concluído
  def done
    if current_user.id == @contract.service.user_id # Verifica se o usuário logado é o prestador do serviço
      @contract.update(done: true)
      redirect_to dashboard_path(@contract), notice: 'Contrato concluído com sucesso.'
    else
      redirect_to dashboard_path(@contract), notice: 'Você não tem permissão para marcar este contrato como concluído.'
    end
  end

  private

  def contract_params
    params.require(:contract).permit(:user_id, :service_id, :date, :status, :done)
  end

  def set_service
    @service = Service.find(params[:id])
  end

  def set_contract
    @contract = Contract.find(params[:id])
  end
end

# <%= link_to 'Accept', update_status_contract_path(@contract, status: 'accept'), method: :patch %> <--- PARA A VIEW
# <%= link_to 'Decline', update_status_contract_path(@contract, status: 'decline'), method: :patch %> <--- PARA A VIEW
