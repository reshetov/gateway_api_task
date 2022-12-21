class ApiActions::ReconnectConnectionAction < ApiActions::BaseAction
  private

  def url_data
    {
      method: :POST,
      path: 'oauth_providers/reconnect'
    }
  end

  def payload
    from_date = (Date.today - 90.days).to_s

    {
      data: {
        connection_id: @connection.connection_id,
        consent: {
          scopes: [
            'account_details',
            'transactions_details'
          ],
          from_date: from_date
        },
        attempt: {
          return_to: callback_connections_url(host: ENV['DEFAULT_URL_HOST'], uuid: @connection.uuid)
        },
        return_connection_id: false
      }
    }
  end
end
