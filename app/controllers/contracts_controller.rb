class ContractsController < ApplicationController
  before_action :set_service, only: [:new, :create]
  before_action :set_contract, only: [:show, :accept, :reject, :done]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @contracts = Contract.all
  end

  def show
    @contract = Contract.where('service_id = ? OR user_id = ?', @contract.service_id, current_user.id)
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

  # Ação personalizada para aceitar o contrato
  def accept
    if current_user.id == @contract.service.user_id # Verifica se o usuário logado é o prestador do serviço
      @contract.update(status: 'Accept')
      redirect_to dashboard_path(@contract), notice: 'Contrato aceito com sucesso.'
    else
      redirect_to dashboard_path(@contract), notice: 'Você não tem permissão para aceitar este contrato.'
    end
  end

  # Ação personalizada para negar o contrato
  def reject
    if current_user.id == @contract.service.user_id # Verifica se o usuário logado é o prestador do serviço
      @contract.update(status: 'Decline')
      redirect_to dashboard_path(@contract), notice: 'Contrato negado com sucesso.'
    else
      redirect_to dashboard_path(@contract), notice: 'Você não tem permissão para negar este contrato.'
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
