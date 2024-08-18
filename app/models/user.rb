class User < ApplicationRecord
  has_secure_password

  # Ensure first name, last name and email are present. Ensure email is unique
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  validates :password, presence: true, length: { minimum: 8 }, confirmation: true

  # Class method to authenticate a user with given credentials
  def self.authenticate_with_credentials(email, password)
    # Find the user by email, downcase it to make the search case-insensitive
    user = User.find_by('lower(email) = ?', email.downcase.strip)

    # Check if user exists and if the provided password is correct
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
