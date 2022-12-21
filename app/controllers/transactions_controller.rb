class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_account
  before_action :find_transactions

  def index; end

  private

  def find_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def find_transactions
    @transactions = @account.transactions
  end
end
