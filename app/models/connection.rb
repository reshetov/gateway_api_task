class Connection < ApplicationRecord
  belongs_to :customer
  has_many :accounts, dependent: :destroy

  enum status: %i[inactive active disabled]
end
