class User < ApplicationRecord
  has_many :rices
  has_many :bids
  has_many :notifications
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:admin, :farmer, :buyer]
  # after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.role ||= :farmer
  # end
end
