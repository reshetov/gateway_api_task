class FetchTransactionsService
  TRANSACTION_ATTRS = %w[duplicated mode status made_on amount currency_code description].freeze

  def initialize(account)
    @account = account
    @errors = []
  end

  def call
    code, data = ApiActions::FetchTransactionsAction.new(account: @account).call
    code == 200 ? delete_removed_transactions(data) && create_transactions(data) : @errors << data['error']

    { result: @errors.empty?, errors: @errors, data: data }
  end

  private

  def delete_removed_transactions(data)
    current_ids = data.map { |trsn| trsn['id'] }
    @account.transactions.where.not(api_id: current_ids).destroy_all
  end

  def create_transactions(data)
    data.each do |trsn|
      transaction = @account.transactions.find_or_initialize_by(api_id: trsn['id'])
      transaction.update(trsn.slice(*TRANSACTION_ATTRS)) if need_update?(transaction, trsn)
    end
  end

  def need_update?(transaction, trsn)
    transaction.new_record? || Time.parse(trsn['updated_at']) > transaction.updated_at
  end
end
