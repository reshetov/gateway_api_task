FactoryBot.define do
  factory :customer do
    user { User.first || user }
    api_id { 'c1' }
    api_secret { 'c1_s' }
  end
end
