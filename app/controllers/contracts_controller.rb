class ContractsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:index, :new, :create,:show]
  before_action :set_contract, only: [:show, :edit, :update, :done, :update_status, :done]


  def index
    @contracts = Contract.where('user_id = ? AND service_id IN (?)', current_user.id, current_user.services.pluck(:id))
  end

  def show
    user_id = current_user.id
    @user = current_user
    @customer_contracts = Contract.where(user_id: user_id)
    @provider_contracts = Contract.where(service_id: current_user.services.pluck(:id))

    # Combine os contratos do cliente e do prestador de serviços em uma única coleção
    @contracts = @customer_contracts.or(@provider_contracts)
  end

  def new
    @user = User.find(params[:user_id])
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    @contract.user = current_user # Atribuindo o usuário logado ao contrato
    @contract.service = @service # Atribuindo o serviço ao contrato
    @contract.status = 'Pending' # Definindo o status de aceitação do contrato pelo usuário prestador do serviço
    @contract.done = false # Definindo o status de conclusão do contrato
    @new_contract_created = true

    if @contract.save
      redirect_to user_service_contract_path(user_id: @contract.user.id, service_id: @contract.service.id, id: @contract.id), notice: 'contract created successfully!'
    else
      render :new, status: :unprocessable_entity, notice: 'Unable to create contract.'
    end
  end

  def update_status
    @contract.status = params[:status]

    if @contract.save
      redirect_to dashboard_path(@contract)
    else
      redirect_to user_service_contract_path(contract.service.id)
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
    @contract.done = params[:done]
    if @contract.save
      redirect_to dashboard_path(@contract)
    else
      redirect_to user_service_contract_path(contract.service.id)
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
