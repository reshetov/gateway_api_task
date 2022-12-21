class CreateCustomerService
  def initialize(user)
    @user = user
    @errors = []
  end

  def call
    code, data = ApiActions::CreateCustomerAction.new(user: @user).call
    code == 200 ? create_user_customer(data) : @errors << data['error']

    { result: @errors.empty?, errors: @errors, data: nil }
  end

  private

  def create_user_customer(data)
    @user_customer = @user.build_customer(api_id: data['id'], api_secret: data['secret'])
    @errors += @user_customer.full_messages unless @user_customer.save
  end
end
