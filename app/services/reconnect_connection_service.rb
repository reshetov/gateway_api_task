class ReconnectConnectionService
  def initialize(connection)
    @connection = connection
    @errors = []
  end

  def call
    code, data = ApiActions::ReconnectConnectionAction.new(connection: @connection).call
    @errors << data['error'] unless code == 200

    { result: @errors.empty?, errors: @errors, data: @errors.empty? ? data['redirect_url'] : nil }
  end
end
