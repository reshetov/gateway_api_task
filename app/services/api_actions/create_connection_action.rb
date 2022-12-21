class ApiActions::CreateConnectionAction < ApiActions::BaseAction
  private

  def url_data
    {
      method: :POST,
      path: 'oauth_providers/create'
    }
  end

  def payload
    from_date = (Date.today - 90.days).to_s

    {
      data: {
        customer_id: @user.customer.api_id,
        country_code: options[:country_code] || FAKE_COUNTRY_CODE,
        provider_code: options[:provider_code] || FAKE_PROVIDER_CODE,
        consent: {
          from_date: from_date,
          scopes: [
            'account_details',
            'transactions_details'
          ]
        },
        attempt: {
          return_to: callback_connections_url(host: ENV['DEFAULT_URL_HOST'], uuid: options[:uuid]),
          from_date: from_date,
          fetch_scopes: [
            'accounts',
            'transactions'
          ]
        },
        return_connection_id: true
      }
    }
  end
end
