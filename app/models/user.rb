class User < ApplicationRecord
  has_many :rices, dependent: :delete_all
  has_many :bids, dependent: :delete_all
  has_many :notifications
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:admin, :farmer, :buyer]
  
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :role, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :contact_number, presence: true
  validates :address, presence: true
end
