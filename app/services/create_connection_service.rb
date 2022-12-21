class CreateConnectionService
  CONNECTION_ATTRS = %w[connection_id connection_secret token expires_at attempt_id].freeze

  def initialize(user)
    @user = user
    @errors = []
  end

  def call
    uuid = SecureRandom.uuid
    code, data = ApiActions::CreateConnectionAction.new(user: @user, uuid: uuid).call
    code == 200 ? create_customer_connection(data, uuid) : @errors << data['error']

    { result: @errors.empty?, errors: @errors, data: @errors.empty? ? data['redirect_url'] : nil }
  end

  private

  def create_customer_connection(data, uuid)
    customer_connection = @user.customer.connections.build(data.slice(*CONNECTION_ATTRS).merge('uuid' => uuid))
    @errors += customer_connection.full_messages unless customer_connection.save
  end
end
