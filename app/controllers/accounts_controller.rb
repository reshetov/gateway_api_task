class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_connection
  before_action :find_accounts

  def index; end

  private

  def find_connection
    @connection = current_user.connections.find(params[:connection_id])
  end

  def find_accounts
    @accounts = @connection.accounts
  end
end
