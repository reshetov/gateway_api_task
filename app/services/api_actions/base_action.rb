class ApiActions::BaseAction
  include Rails.application.routes.url_helpers
  attr_reader :options

  FAKE_COUNTRY_CODE = 'XF'.freeze
  FAKE_PROVIDER_CODE = 'fake_oauth_client_xf'.freeze

  def initialize(params = {})
    @api_service = SaltedgeApiService.new
    @options = params
    @user = options[:user]
    @connection = options[:connection]
    @account = options[:account]
  end

  def call
    @api_service.request(url_data[:method], url_data[:path], payload)
  end

  private

  def url_data
    {
      method: :GET,
      path: ''
    }
  end

  def payload
    raise NotImplementedMethod
  end
end
