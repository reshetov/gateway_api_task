class Transaction < ApplicationRecord
  belongs_to :account

  enum mode: %i[normal fee transfer]
  enum status: %i[pending posted]
end
