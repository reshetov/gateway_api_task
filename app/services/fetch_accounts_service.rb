class FetchAccountsService
  ACCOUNT_ATTRS = %w[name nature balance currency_code].freeze

  def initialize(connection)
    @connection = connection
    @errors = []
  end

  def call
    code, data = ApiActions::FetchAccountsAction.new(connection: @connection).call
    code == 200 ? create_accounts(data) && fetch_transacions : @errors << data['error']

    { result: @errors.empty?, errors: @errors, data: data }
  end

  private

  def create_accounts(data)
    data.each do |acc|
      account = @connection.accounts.find_or_initialize_by(api_id: acc['id'])
      account.update(acc.slice(*ACCOUNT_ATTRS)) if need_update?(account, acc)
    end
  end

  def need_update?(account, acc)
    account.new_record? || Time.parse(acc['updated_at']) > account.updated_at
  end

  def fetch_transacions
    @connection.accounts.find_each { |account| FetchTransactionsService.new(account).call }
  end
end
