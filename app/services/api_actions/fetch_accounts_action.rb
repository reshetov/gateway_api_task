class ApiActions::FetchAccountsAction < ApiActions::BaseAction
  private

  def url_data
    {
      method: :GET,
      path: 'accounts'
    }
  end

  def payload
    {
      connection_id: @connection.connection_id
    }
  end
end
