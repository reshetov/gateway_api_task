class RefreshConnectionService
  def initialize(connection)
    @connection = connection
    @errors = []
  end

  def call
    code, data = ApiActions::RefreshConnectionAction.new(connection: @connection).call
    code == 200 ? update_refresh_date(data) : @errors << data['error']

    { result: @errors.empty?, errors: @errors, data: @errors.empty? ? data : {} }
  end

  private

  def update_refresh_date(data)
    rtime = data[:next_refresh_possible_at] ? Time.parse(data[:next_refresh_possible_at]) : Time.now + 1.hour
    @connection.update(next_refresh: rtime)
  end
end
