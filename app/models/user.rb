class User < ApplicationRecord
  # Include default Devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :expenses, dependent: :destroy

  # Validations
  validates :username, presence: true, uniqueness: true

  has_many :monthly_budgets, dependent: :destroy
end
