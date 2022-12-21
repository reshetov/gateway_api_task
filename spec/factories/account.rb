FactoryBot.define do
  factory :account do
    connection { Connection.first || customer }
    api_id { '0001' }
    name { 'Name' }
    nature { 'account' }
    balance { 9.99 }
    currency_code { 'USD' }
  end
end
