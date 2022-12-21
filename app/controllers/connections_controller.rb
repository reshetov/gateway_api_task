class ConnectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_connection, only: %i[destroy refresh reconnect]

  def create
    response = CreateConnectionService.new(current_user).call
    return redirect_to response[:data] if response[:result]

    redirect_to :root, alert: generate_error_message(response[:errors])
  end

  def destroy
    response = DestroyConnectionService.new(@connection).call

    redirect_to :root, alert: response[:result] ? nil : generate_error_message(response[:errors])
  end

  def refresh
    response = RefreshConnectionService.new(@connection).call
    return refetch_accounts if response[:result]

    redirect_to :root, alert: response[:result] ? nil : generate_error_message(response[:errors])
  end

  def reconnect
    response = ReconnectConnectionService.new(@connection).call
    return redirect_to response[:data] if response[:result]

    redirect_to :root, alert: generate_error_message(response[:errors])
  end

  def callback
    @connection = find_by_uuid
    return head :not_found unless @connection
    return redirect_to :root, alert: generate_error_message(params[:error]) if params[:error]

    response = AuthorizeConnectionService.new(@connection, callback_params).call
    return refetch_accounts if response[:result]

    redirect_to :root, alert: generate_error_message(response[:errors])
  end

  private

  def find_by_uuid
    current_user.connections.find_by(uuid: params[:uuid])
  end

  def find_connection
    @connection = current_user.connections.find(params[:id])
  end

  def refetch_accounts
    response = FetchAccountsService.new(@connection).call
    redirect_to :root, alert: response[:result] ? nil : generate_error_message(response[:errors])
  end

  def callback_params
    params.permit(:error, :access_token, :state)
  end
end
