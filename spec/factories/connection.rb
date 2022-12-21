FactoryBot.define do
  factory :connection do
    uuid { 'UUID' }
    customer { Customer.first || customer }
    connection_id { '0001' }
    connection_secret { 'c_secret' }
    expires_at { Date.tomorrow }
    attempt_id { '0001' }
    token { 'token' }
    access_token { nil }
    status { 'active' }
    next_refresh { nil }
  end
end
