class ApiActions::RefreshConnectionAction < ApiActions::BaseAction
  private

  def url_data
    {
      method: :PUT,
      path: "connections/#{@connection.connection_id}/refresh"
    }
  end

  def payload
    {
      data: {
        attempt: {
          fetch_scopes: [
            'accounts',
            'transactions',
          ]
        }
      }
    }
  end
end
