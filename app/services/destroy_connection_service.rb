class DestroyConnectionService
  def initialize(connection)
    @connection = connection
    @errors = []
  end

  def call
    code, data = ApiActions::DestroyConnectionAction.new(connection: @connection).call
    code == 200 ? destroy_connection : @errors << data['error']

    { result: @errors.empty?, errors: @errors, data: nil }
  end

  private

  def destroy_connection
    @errors += @connection.errors.full_messages unless @connection.destroy
  end
end
