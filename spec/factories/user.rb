FactoryBot.define do
  factory :user do
    email { 'email@test.com' }
    firstname { 'Test' }
    lastname { 'User' }
    password { '123123123' }
  end
end
