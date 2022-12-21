class ApiActions::DestroyConnectionAction < ApiActions::BaseAction
  private

  def url_data
    {
      method: :DELETE,
      path: "connections/#{@connection.connection_id}"
    }
  end

  def payload
    {}
  end
end
