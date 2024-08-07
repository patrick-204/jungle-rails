class User < ApplicationRecord
  has_secure_password

  # Ensure first name, last name and email are present. Ensure email is unique
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
end
