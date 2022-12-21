class ApiActions::FetchTransactionsAction < ApiActions::BaseAction
  private

  def url_data
    {
      method: :GET,
      path: 'transactions'
    }
  end

  def payload
    {
      connection_id: @account.connection.connection_id,
      account_id: @account.api_id
    }
  end
end
