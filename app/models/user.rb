class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
  has_one :customer, dependent: :destroy
  has_many :connections, through: :customer
  has_many :accounts, through: :connections

  validates :email, :firstname, :lastname, presence: true
  after_commit :create_customer, on: [:create]

  def fullname
    "#{firstname} #{lastname}"
  end

  private

  def create_customer
    CreateCustomerService.new(self).call
  end
end
