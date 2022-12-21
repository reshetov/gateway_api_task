class AuthorizeConnectionService
  def initialize(connection, params)
    @connection = connection
    @params = params
    @errors = []
  end

  def call
    code, data = ApiActions::AuthorizeConnectionAction.new(connection: @connection, auth_params: @params).call
    code == 200 ? activate_connection && update_refresh_date(data) : @errors << data['error']

    { result: @errors.empty?, errors: @errors, data: @errors.empty? ? data : {} }
  end

  private

  def activate_connection
    @connection.active!
  end

  def update_refresh_date(data)
    rtime = data[:next_refresh_possible_at] ? Time.parse(data[:next_refresh_possible_at]) : Time.now + 1.hour
    @connection.update(next_refresh: rtime)
  end
end
