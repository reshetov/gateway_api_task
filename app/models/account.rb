class Account < ApplicationRecord
  belongs_to :connection
  has_many :transactions, dependent: :destroy

  enum nature: %i[account bonus card checking credit credit_card debit_card
                  ewallet insurance investment loan mortgage savings]
end
