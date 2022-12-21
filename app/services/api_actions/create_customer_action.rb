class ApiActions::CreateCustomerAction < ApiActions::BaseAction
  private

  def url_data
    {
      method: :POST,
      path: 'customers'
    }
  end

  def payload
    { data: { identifier: @user.email } }
  end
end
