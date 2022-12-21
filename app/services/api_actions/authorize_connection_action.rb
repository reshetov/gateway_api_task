class ApiActions::AuthorizeConnectionAction < ApiActions::BaseAction
  private

  def url_data
    {
      method: :PUT,
      path: 'oauth_providers/authorize'
    }
  end

  def payload
    {
      data: {
        connection_id: @connection.connection_id,
        query_string: options[:auth_params].to_query
      }
    }
  end
end